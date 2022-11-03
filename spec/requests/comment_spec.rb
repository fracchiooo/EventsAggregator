require 'rails_helper'


RSpec.describe "Comments", type: :request do
  describe "GET /index" do

    event = Event.create(event_id: 'asdASrqsdfAS', coordinates: '12.1212,12.1212', organizer_id: 'asdWQWEfda', origin: 'predicthq')
    user = User.create(id: 10, nome: 'fabriidwawdi', username: 'asdwqwdqaddd', cognome: 'fasdqweaaa', email: 'fabriadsqweii@gmail.com', password: 'asdasd')
    user2 = User.create(id: 11, role: 'admin', nome: 'fabriidwawddddddi', username: 'asdwqdddddwdqaddd', cognome: 'fasdqweaddddaa', email: 'fabriaddddddsqweii@gmail.com', password: 'asdasd')

    it 'creates a new comment from the user for the event' do
      sign_in user
      post event_comments_path(event),  params: { comment: { testo: 'Testo di provaaa' }, event_id: event.event_id }
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to match(/Comment was successfully created./)
    end

    it 'destroys a comment from the user for the event' do
      sign_in user
      comment = Comment.create(
        event: event,
        user: user,
        testo: 'Testo prova'
      )
      delete event_comment_path(event.id, comment.id)
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to match(/Comment was successfully destroyed./)
    end

    it 'fails to destroy a comment of another user for the event' do
      sign_in user
      comment = Comment.create(
        event: event,
        user: user2,
        testo: 'Testo prova'
      )
      delete event_comment_path(event.id, comment.id)
      expect(flash[:alert]).to be_present
      expect(flash[:alert]).to match(/non autorizzato alla destroy./)
    end

    it 'destroys a comment of another user for the event as an admin' do
      sign_in user2
      comment = Comment.create(
        event: event,
        user: user,
        testo: 'Testo prova'
      )
      delete event_comment_path(event.id, comment.id)
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to match(/Comment was successfully destroyed./)
    end

  end
end
