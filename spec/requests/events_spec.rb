require 'rails_helper'

RSpec.describe "EventsControllers", type: :request do

  describe "POST /events" do
    it 'fails to create a new event because only API response can' do
      post events_path, params: { event: { event_id: 'ASDrubalino', organizer_id: 'ASaweadasrwa', coordinates: '12.221222,50.141234'} }
      expect(response).to have_http_status(:unprocessable_entity)
      # expect(response).to_not redirect_to( event_url(Event.find_by(event_id: 'ASDrubalino')) )
    end
  end

end
