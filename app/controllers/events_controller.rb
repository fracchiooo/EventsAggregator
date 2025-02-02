class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    @events = Predicthq.getEvents(params[:q], params[:start_date], params[:end_date], params[:current_location], params[:loc], params[:category])
    @events2 = Ticketmaster.getEvents(params[:q], params[:start_date], params[:end_date], params[:current_location], params[:loc], params[:category])

    key = params[:q].to_s.present? ? "#{params[:q].capitalize()}" : ""
    if params[:current_location].to_i == 0 then
      luogo = params[:loc].to_s.present? ? " in #{params[:loc]}" : ""
    else
      luogo = params[:loc].to_s.present? ? " in #{Geocoder.search(params[:loc]).first.city} " : ""
    end
    categ = params[:category].to_s.present? ? " regarding #{params[:category]}" : ""
    if params[:start_date].to_s.present? || params[:end_date].to_s.present? then int= " on the dates" else int="" end
    da = params[:start_date].to_s.present? ? " from #{params[:start_date]}" : ""
    fino = params[:end_date].to_s.present? ? " to #{params[:end_date]}" : ""
    @cerco = key+luogo+categ+int+da+fino

    flash.now[:alert] = 'Eventi acquisiti'
  end

  # GET /events/1 or /events/1.json
  def show
    if @event.origin == "predicthq"
      @event_data = Predicthq.getEvent(@event.event_id)
    elsif @event.origin == "ticketmaster"
      @event_data = Ticketmaster.getEvent(@event.event_id)
    end


    @sum_likes = 0
    if LikeEvent.where(event_id: @event.id.to_s).exists?
      event_likes = LikeEvent.where(event_id: @event.id.to_s)

      if user_signed_in? && event_likes.where(user_id: current_user.id).exists?
        @user_like = event_likes.find_by(user_id: current_user.id).like
      end
      
      event_likes.each do |like|
        if like.like
          @sum_likes = @sum_likes + 1
        elsif like.like == false
          @sum_likes = @sum_likes - 1
        end
      end
    end
    

    favorite_exists = Favorite.where(event: @event, user: current_user) == [] ? false : true
    @favorite_text = favorite_exists ? "Togli dai preferiti" : "Aggiungi ai preferiti"


    partecipant_exists = Partecipant.where(event: @event, user: current_user) == [] ? false : true
    @partecipant_text = partecipant_exists ? "Rimuovi Partecipazione" : "Segna Partecipazione"
    @partecipants = Partecipant.where(event: @event).count


    check_photos_existants = DrivePhoto.where(event: @event)
    if check_photos_existants.present? 
      check_photos_existants.each do |photo|
        begin
          uri=URI.parse(photo.drive_url)
          http= Net::HTTP.new(uri.host,uri.port)
          http.use_ssl=true
          http.verify_mode= OpenSSL::SSL::VERIFY_NONE     
          request= Net::HTTP::Get.new(uri.request_uri)
          response=http.request(request)
          if response.code == "404"
            # link non più valido, elimino entry
            DrivePhoto.where(event: @event, drive_url: photo.drive_url).destroy_all
            puts "#{res.code} error - #{photo.drive_url} does not exists anymore."
          end
        rescue
            puts "breaking for #{photo.drive_url}"
        end
      end
    end
    @photos = DrivePhoto.where(event: @event)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find_by(event_id: params[:id]) or not_found
    end

    def not_found
      # raise ActionController::RoutingError.new('Not Found')
      render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
    end    

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:event_id, :organizer_id, :coordinates)
    end
end
