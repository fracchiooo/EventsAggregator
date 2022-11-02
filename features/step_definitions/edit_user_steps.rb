require 'capybara/rails'

button_id = 0

Given(/^un utente amministratore$/) do
  admin_user = FactoryBot.create(:user_random_admin)
  login_as(admin_user)
end

Given(/^un utente da moderare$/) do
  user = FactoryBot.create(:user_random)
  button_id = user.id.to_s
end

When(/^visita la pagina utenti/) do
  visit '/users'
end

When(/^vedo il pulsante "(.*?)"$/) do |text|
  find("button", :id => button_id)
end

When(/^clicco il pulsante "Modera Utente"$/) do
  click_button button_id
end

When(/^vedo la pagina Impostazioni Profilo/) do
  find('h4', :text => 'Impostazioni Profilo')
end

When(/^modifico l'username/) do
  fill_in 'user_username', with: 'new_username'
end

When(/^clicco il pulsante "Salva Modifiche"$/) do
  click_button 'Salva Modifiche'
end

Then(/^vedo la Home Page/) do
  find("a", :text => 'Visualizza Eventi')
end
