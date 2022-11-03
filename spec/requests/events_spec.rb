require 'rails_helper'

RSpec.describe "EventsControllers", type: :request do

  describe "/events" do
    it 'fails to get a not existing event' do
      get '/events/test'
      expect(response).to have_http_status(:not_found)
    end
  end

end
