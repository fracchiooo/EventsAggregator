class Oauth2Controller < ApplicationController
  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s, allow_other_host: true
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    if session[:google_type] == 'calendar'
      redirect_to calendar_add_event_url
    elsif session[:google_type] == 'drive'
      redirect_to session[:referer]
    else
      redirect_to root_url
    end
  end

  private

  def client_options
    {
      client_id: Rails.application.credentials[:google_id],
      client_secret: Rails.application.credentials[:google_secret],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR + ' ' + Google::Apis::DriveV3::AUTH_DRIVE,
      redirect_uri: oauth2_callback_url
    }
  end

  def getClientOptions
    return client_options
  end

  cattr_accessor :getClientOptions
end