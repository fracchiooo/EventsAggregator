require 'capybara/rails'

Given(/^un utente registrato$/) do
    user = FactoryBot.create(:user_random)
    # login_as(user) # non credo necessario qui, ma non capisco perché dice che non esiste..
    # https://github.com/heartcombo/devise/wiki/How-To:-Test-with-Capybara
    # https://sajadtorkamani.com/login-devise-user-in-capybara-tests/
end

When(/^visita la pagina degli Eventi/) do
    visit '/events'
end

When(/^clicco la checkbox "(.*?)"$/) do |text|
    check text
end

When(/^clicco la submit "(.*?)"$/) do |text|
    click_button 'submit-button'
end

Then(/^vedo gli eventi vicini/) do
    page.has_text?(:visible, 'Results for:', exact: true)
end