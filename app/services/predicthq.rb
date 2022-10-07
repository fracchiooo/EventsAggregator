class Predicthq

    def self.getEvents
        begin
            # TODO: gestire i parametri, questa è ricerca di default
            url="https://api.predicthq.com/v1/events/?place.scope=2641170&active.gte=2022-10-01&active.lte=2022-10-31&category=sports&sort=rank"

            uri=URI.parse(url)
            http= Net::HTTP.new(uri.host,uri.port)
            http.use_ssl=true
            http.verify_mode= OpenSSL::SSL::VERIFY_NONE
            request= Net::HTTP::Get.new(uri.request_uri)
            request['Authorization'] = "Bearer #{Rails.application.credentials[:predicthq_access_token]}"
            response=http.request(request)
            res=JSON.parse(response.body)
        rescue => exception
            # TODO: gestire l'errore
            return "errore: ", (response).to_json, (exception).to_json
        end
        count = res['count']
        results = res['results']

        # per ogni evento risultato nella ricerca
        results.each do |event|
            # se non si trova già nel database
            if Event.where(event_id: event['id']).blank? then
                # lo aggiungo al database
                e = Event.new(  event_id:event['id'], 
                                organizer_id:event['entities'][0]['entity_id'], 
                                coordinates: event['geo']['geometry']['coordinates'].join(",") )
                e.save!
            end
        end

        return results
    end

end