require 'rails_helper'

RSpec.describe User, type: :model do

  context 'when created/modified user' do
    it 'has a valid user' do
      user = User.create(id: 1, nome: 'paolo', username: 'cicciolina', cognome: 'rossi', email: 'paolo@gmail.com', password: 'asdasd')
      expect(user).to be_valid
    end
  
    it 'cannot have a short password' do
      user = User.create(id: 1, nome: 'paolo', username: 'cicciolina', cognome: 'rossi', email: 'paolo@gmail.com', password: 'asd')
      expect(user).to_not be_valid
    end
  
    it 'must have a \'nome\'' do
      user = User.create(id: 1, username: 'cicciolina', cognome: 'rossi', email: 'paolo@gmail.com', password: 'asdasd')
      expect(user).to_not be_valid
    end
  
    it 'must have a \'username\'' do
      user = User.create(id: 1, nome: 'paolo', cognome: 'rossi', email: 'paolo@gmail.com', password: 'asdasd')
      expect(user).to_not be_valid
    end
  
    it 'must have a \'cognome\'' do
      user = User.create(id: 1, nome: 'paolo', username: 'cicciolina', email: 'paolo@gmail.com', password: 'asdasd')
      expect(user).to_not be_valid
    end
  
    it 'must match password and password_confirmation' do
      user = User.create(id: 1, nome: 'paolo', username: 'cicciolina', cognome: 'rossi', email: 'paolo@gmail.com', password: 'asdasd', password_confirmation: 'asd')
      expect(user).to_not be_valid
    end
  end

end
