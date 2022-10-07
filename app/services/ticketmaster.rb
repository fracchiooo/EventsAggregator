class Ticketmaster

    def self.getEvents
        begin
            # TODO: gestire i parametri, questa è ricerca di default
            url="https://app.ticketmaster.com/discovery/v2/events.json?apikey=#{Rails.application.credentials[:ticketmaster][:api_key]}"

            uri=URI.parse(url)
            http= Net::HTTP.new(uri.host,uri.port)
            http.use_ssl=true
            http.verify_mode= OpenSSL::SSL::VERIFY_NONE
            request= Net::HTTP::Get.new(uri.request_uri)
            response=http.request(request)
            res=JSON.parse(response.body)
        rescue => exception
            # TODO: gestire l'errore
            return "errore: ", (response).to_json, (exception).to_json
        end
        results = res['_embedded']['events']

        results.each do |event|
            # se non si trova già nel database
            if Event.where(event_id: event['id']).blank? then
                # lo aggiungo al database
                e = Event.new(  event_id: event['id'], 
                                organizer_id: "event['promoter']['id']", 
                                coordinates: "test" )
                                # TODO: promoter non sempre presente... coordinate non presenti
                e.save!
            end
        end

        return results
    end

end