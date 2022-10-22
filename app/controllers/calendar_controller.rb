class CalendarController < ApplicationController
  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s, allow_other_host: true
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to calendar_add_event_url
  end

  #http://127.0.0.1:3000/calendar/add_event?event_name=test&location=Roma&start_date=2022-10-22T09:00:00-07:00&end_date=2022-10-28T09:00:00-07:00
  def add_event
    if !session[:saved_params].nil?
      params[:event_name] = session[:saved_params]["event_name"]
      params[:location] = session[:saved_params]["location"]
      params[:start_date] = session[:saved_params]["start_date"]
      params[:end_date] = session[:saved_params]["end_date"]
    end

    if !params.has_key?(:event_name) || !params.has_key?(:location) || !params.has_key?(:start_date) || !params.has_key?(:end_date)
      return redirect_to root_url
    end

    if session[:authorization].nil?
      session[:saved_params] = params
      return redirect_to calendar_redirect_url
    end


    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    event = Google::Apis::CalendarV3::Event.new(
      summary: params[:event_name],
      location: params[:location],
      description: 'Reminder Evento',
      start: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: params[:start_date],
        time_zone: 'Europe/Rome'
      ),
      end: Google::Apis::CalendarV3::EventDateTime.new(
        date_time: params[:end_date],
        time_zone: 'Europe/Rome'
      ),
      reminders: Google::Apis::CalendarV3::Event::Reminders.new(
        use_default: false,
        overrides: [
          Google::Apis::CalendarV3::EventReminder.new(
            reminder_method: 'email',
            minutes: 24 * 60
          )
        ]
      )
    )

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    calendar_id = 'primary'

    begin
      response = service.insert_event(calendar_id, event)
    rescue
      session[:saved_params] = params
      return redirect_to calendar_redirect_url
    end

    session[:saved_params] = nil

    redirect_to response.html_link, allow_other_host: true
  end

  private

  def client_options
    {
      client_id: Rails.application.credentials[:calendar_google_id],
      client_secret: Rails.application.credentials[:calendar_google_secret],
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: calendar_callback_url
    }
  end
end