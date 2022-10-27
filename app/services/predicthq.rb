require 'cgi' #URL-encoding

class Predicthq

    def self.getEvents(keyword, first_date, fin_date, current_loc, loc, category)
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
            if category.to_s.present? then
                cat = "category=#{category.downcase.parameterize(separator:'-')}&"
            else
                cat = ""
            end

            if loc.to_s.present?
                if current_loc.to_i == 0
                    # non usa la posizione corrente (not checked)
                    # find_coords = "https://maps.googleapis.com/maps/api/geocode/json?address=#{loc}&key=#{Rails.application.credentials[:google_api_key_places]}"
                    # coordinates = find_coords_res['results'][0]['geometry']['location']['lat'].to_s + "," + find_coords_res['results'][0]['geometry']['location']['lng'].to_s    
                    find_coords = Geocoder.search(loc)
                    coordinates = find_coords.first.coordinates[0].to_s + "," + find_coords.first.coordinates[1].to_s
                    coords = "within=50km@#{coordinates}&"
                elsif current_loc.to_i == 1
                    # usa posizione corrente (checked)
                    coords = "within=50km@#{CGI.unescape(loc)}&"
                end
            else
                coords = ""
            end


            # url="https://api.predicthq.com/v1/events/?place.scope=2641170&"+query+"&active.gte=2022-10-01&active.lte=2022-10-31&category=sports&sort=rank" #ipotetica chiamata di default?
            url="https://api.predicthq.com/v1/events/?"+query+start_d+end_d+coords+cat

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
                    if event['entities'].present? then entity = event['entities'][0]['entity_id'] end
                    e = Event.new(  event_id:event['id'], 
                                    organizer_id: entity, 
                                    coordinates: event['location'][1].to_s+", "+event['location'][0].to_s,
                                    origin: "predicthq" )
                    e.save!
                end
            end
        end

        return results
    end

    def self.getEvent(event_id)
        begin
            url="https://api.predicthq.com/v1/events/?id=" + event_id
            uri=URI.parse(url)
            http= Net::HTTP.new(uri.host,uri.port)
            http.use_ssl=true
            http.verify_mode= OpenSSL::SSL::VERIFY_NONE
            request= Net::HTTP::Get.new(uri.request_uri)
            request['Authorization'] = "Bearer #{Rails.application.credentials[:predicthq_access_token]}"
            response=http.request(request)
            res=JSON.parse(response.body)
        rescue => exception
            return "errore: ", (response).to_json, (exception).to_json
        end

        res = res['results'][0]

        result = Hash.new
        
        result[:title] = res['title']
        result[:description] = res['description']
        start_date = Date::strptime(res['start'], '%Y-%m-%dT%H:%M:%SZ').strftime('%d/%m/%Y')
        end_date = Date::strptime(res['end'], '%Y-%m-%dT%H:%M:%SZ').strftime('%d/%m/%Y')
        if start_date == end_date 
            result[:date] = start_date
        else
            result[:date] = start_date + " - " + end_date
        end 
        latlong_img = res['location'][0].to_s + "," + res['location'][1].to_s
        result[:image] = "https://maps.geoapify.com/v1/staticmap?style=osm-bright&width=2048&height=1152&center=lonlat:#{latlong_img}&zoom=11.7625&marker=lonlat:#{latlong_img};type:awesome;color:%23bb3f73;size:x-large;icon:glass-martini&apiKey=#{Rails.application.credentials[:geoapify_api_key]}"
        result[:coordinates] = res['location'][1].to_s+", "+res['location'][0].to_s

        return result
    
    end

end