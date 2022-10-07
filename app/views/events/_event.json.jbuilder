json.extract! event, :id, :event_id, :organizer_id, :coordinates, :created_at, :updated_at
json.url event_url(event, format: :json)
