require 'rails_helper'

RSpec.describe Comment, type: :model do
  user = User.create(id: 6, nome: 'paolooo', username: 'cicciolinaaa', cognome: 'rossiii', email: 'paolooo@gmail.com', password: 'asdasd')
  event = Event.create(event_id: 'asdASrqsdfdawd', coordinates: '12.1212,12.1212', organizer_id: 'asdWQWEfda', origin: 'predicthq')
  
  it 'has one user and one event' do
    comment = Comment.new(
      user: user,
      event: event,
      testo: 'Testo di prova'
    )
    expect(comment).to be_valid
  end

  it 'fails because it doesn\'t belongs to an event' do
    comment = Comment.new(
      user: user,
      testo: 'Testo di prova'
    )
    expect(comment).to_not be_valid
  end

  it 'fails because it doesn\'t belongs to an user' do
    comment = Comment.new(
      event: event,
      testo: 'Testo di prova'
    )
    expect(comment).to_not be_valid
  end

end
