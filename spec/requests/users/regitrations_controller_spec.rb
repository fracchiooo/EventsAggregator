require 'rails_helper'

RSpec.describe "Users::RegitrationsControllers", type: :request do
  
  user = User.create(id: 2, nome: 'fabri', username: 'asd', cognome: 'fa', email: 'fabri@gmail.com', password: 'asdasd')
  admin = User.create(id: 3, role: 'admin', nome: 'tizio', username: 'rest', cognome: 'lol', email: 'tizio@asd.com', password: 'asdasd')

  describe "PUT /users/edit" do

    it 'updates his own \'username\'' do
      sign_in admin
      put '/users', params: { user: { username: 'asdrubale' } }
      expect(response).to redirect_to(home_path)
      expect(User.find(admin.id).username).to match(/asdrubale/)
    end

    it 'updates another user \'username\'' do
      sign_in admin
      put '/users', params: { user: { id: user.id, username: 'ercole' } }
      expect(response).to redirect_to(home_path)
      expect(User.find(user.id).username).to match(/ercole/)
    end

    it 'fails to update another user \'username\' as non-admin' do
      sign_in user
      put '/users', params: { user: { id: admin.id, username: 'ercole' } }
      expect(response).to redirect_to(home_path)
      expect(User.find(user.id).username).to match(/ercole/)
      expect(User.find(admin.id).username).to_not match(/ercole/)
    end

  end

end
