require 'rails_helper'

RSpec.describe Event, type: :model do
  
  context 'when created event' do
    it 'creates a valid event' do
      event = Event.create(event_id: 'asdASrqsdf', coordinates: '12.1212,12.1212', organizer_id: 'asdWQWEfda', origin: 'predicthq')
      expect(event).to be_valid
    end

    it 'fails to create a new event because \'origin\' field can\'t be blank' do
      event = Event.create(event_id: 'asdASrqsdf', coordinates: '12.1212,12.1212', organizer_id: 'asdWQWEfda')
      expect(event).to_not be_valid
    end

    it 'fails to create a new event because \'coordinates\' field can\'t be blank' do
      event = Event.create(event_id: 'asdASrqsdf', organizer_id: 'asdWQWEfda', origin: 'predicthq')
      expect(event).to_not be_valid
    end

    it 'fails to create a new event because \'event_id\' field can\'t be blank' do
      event = Event.create(coordinates: '12.1212,12.1212', organizer_id: 'asdWQWEfda', origin: 'predicthq')
      expect(event).to_not be_valid
    end
  end

end
