require 'cgi' #URL-encoding

class Predicthq

    def self.getEvents(keyword, first_date, fin_date)
        begin    
            query = keyword.to_s.present? ? "q=#{CGI.escape(keyword)}&" : ""
            if first_date.to_s.present?
                start_date_temp = Date::strptime(first_date, "%Y-%m-%d").strftime('%Y-%m-%dT%H:%M:%SZ')
                start_d = "start.gte=#{start_date_temp}&"
            else 
                start_d = "" 
            end
            if fin_date.to_s.present?
                end_date_temp = Date::strptime(fin_date, "%Y-%m-%d").strftime('%Y-%m-%dT%H:%M:%SZ')
                end_d = "start.lte=#{end_date_temp}&" 
            else 
                end_d = "" 
            end

            # url="https://api.predicthq.com/v1/events/?place.scope=2641170&"+query+"&active.gte=2022-10-01&active.lte=2022-10-31&category=sports&sort=rank" #ipotetica chiamata di default?
            url="https://api.predicthq.com/v1/events/?"+query+start_d+end_d

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

        if count.to_i > 0
            # per ogni evento risultato nella ricerca
            results.each do |event|
                # se non si trova già nel database
                if Event.where(event_id: event['id']).blank? then
                    # lo aggiungo al database

                    #   TODO: controllare se organizer_id e coordinates sono presenti
                    # organizer_id:event['entities'][0]['entity_id']
                    # coordinates: event['geo']['geometry']['coordinates'].join(",")
                    e = Event.new(  event_id:event['id'], 
                                    organizer_id:"event['entities'][0]['entity_id']", 
                                    coordinates: event['geo']['geometry']['coordinates'].join(",") )
                    e.save!
                end
            end
        end

        return results
    end

end