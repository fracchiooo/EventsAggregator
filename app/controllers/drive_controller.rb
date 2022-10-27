class DriveController < ApplicationController
  def login
    session[:google_type] = 'drive'
    session[:referer] = request.referer

    redirect_to oauth2_redirect_url
  end

  def logout
    session[:authorization] = nil

    respond_to do |format|
      format.html {redirect_to request.referer}
      format.json {head :no_content}
    end
  end

  def add_media
    if session[:authorization].nil? || !params.has_key?(:event) || !params.has_key?(:media) || !user_signed_in?
      return render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    client = Signet::OAuth2::Client.new(Oauth2Controller.getClientOptions)
    client.update!(session[:authorization])

    service = Google::Apis::DriveV3::DriveService.new
    service.authorization = client

    folder_id = get_folder_id(service)

    if folder_id.nil?
      return render json: { error: 'Can\'t access folder' }
    end

    begin
      file_metadata = Google::Apis::DriveV3::File.new(name: params[:media].original_filename, parents: [folder_id])
      file = service.create_file(file_metadata, fields: 'id', upload_source: params[:media].tempfile, content_type: params[:media].content_type)
    
      file = service.get_file(file.id, fields: 'webContentLink')
      file_url = file.web_content_link

      if params[:media].content_type.start_with?('video')
        file_url += '&type=video'
      end

      drive_photo = DrivePhoto.new(event_id: params[:event], user_id: current_user.id, drive_url: file_url)
      drive_photo.save

      respond_to do |format|
        format.html {redirect_to request.referer}
        format.json {head :no_content}
      end
    rescue
      return render json: { error: 'Can\'t upload file' }
    end
  end

  def get_folder_id(service)
    begin
      response = service.list_files(q: "name='EventsAggregatorMedia' and mimeType='application/vnd.google-apps.folder' and trashed=false")
      if response.files.empty?
        file_metadata = Google::Apis::DriveV3::File.new(name: 'EventsAggregatorMedia', mime_type: 'application/vnd.google-apps.folder')
        file = service.create_file(file_metadata, fields: 'id')
        folder_id = file.id
      else
        folder_id = response.files[0].id
      end

      permission = Google::Apis::DriveV3::Permission.new(type: 'anyone', role: 'reader')
      service.create_permission(folder_id, permission, fields: 'id')

      return folder_id
    rescue
      return nil
    end
  end
end