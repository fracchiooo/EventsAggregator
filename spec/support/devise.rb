# frozen_string_literal: true

RSpec.configure do |config|
    config.include Warden::Test::Helpers
    allow(controller).to receive(:current_user).and_return(user)
end