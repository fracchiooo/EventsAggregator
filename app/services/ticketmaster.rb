require 'cgi' #URL-encoding

class Ticketmaster

    def self.getEvents(keyword, first_date, fin_date, current_loc, loc, category)
        begin
            q = keyword.to_s.present? ? "keyword=#{keyword}&" : ""
            if first_date.to_s.present?
                start_date_temp = Date::strptime(first_date, "%Y-%m-%d").strftime('%Y-%m-%dT%H:%M:%SZ')
                start_d = "startDateTime=#{start_date_temp}&"
            else 
                start_d = "" 
            end
            if fin_date.to_s.present?
                end_date_temp = Date::strptime(fin_date, "%Y-%m-%d").strftime('%Y-%m-%dT%H:%M:%SZ')
                end_d = "endDateTime=#{end_date_temp}&"
            else 
                end_d = "" 
            end
            if category.to_s.present? && category!="nessuno" then
                cat = "classificationName=#{CGI.escape(category).to_s}&"
            else
                cat = ""
            end

            # TODO: se due RICHIESTE UGUALI di seguito, errore e non funziona più la ricerca città con google
            if loc.to_s.present?
                if current_loc.to_i == 0
                    # non usa la posizione corrente (not checked)
                    # find_coords = "https://maps.googleapis.com/maps/api/geocode/json?address=#{loc}&key=#{Rails.application.credentials[:google_api_key_places]}" #place_id=#{loc}
                    # coordinates = find_coords_res['results'][0]['geometry']['location']['lat'].to_s + "," + find_coords_res['results'][0]['geometry']['location']['lng'].to_s    
                    find_coords = Geocoder.search(loc)
                    coordinates = find_coords.first.coordinates[0].to_s + "," + find_coords.first.coordinates[1].to_s
                    coords = "geoPoint=#{CGI.escape(coordinates)}&radius=50&unit=km&"
                elsif current_loc.to_i == 1
                    # usa posizione corrente (checked)
                    coords = "geoPoint=#{CGI.unescape(loc)}&radius=50&unit=km&"
                end
            else
                coords = ""
            end


            url="https://app.ticketmaster.com/discovery/v2/events.json?"+q+start_d+end_d+coords+cat+"apikey=#{Rails.application.credentials[:ticketmaster][:api_key]}"

            uri=URI.parse(url)
            http= Net::HTTP.new(uri.host,uri.port)
            http.use_ssl=true
            http.verify_mode= OpenSSL::SSL::VERIFY_NONE
            request= Net::HTTP::Get.new(uri.request_uri)
            response=http.request(request)
            res=JSON.parse(response.body)
        rescue => exception
            # TODO: gestire l'errore
            return "errore: ", @keyword, (response).to_json, (exception).to_json
        end
        num_res = res['page']['totalElements']

        # risultato della ricerca non vuoto
        if num_res.to_i > 0
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
        end

        return results
    end

end