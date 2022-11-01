require 'capybara/rails'

Given(/^un utente registrato$/) do
    user = FactoryBot.create(:user_random)
    login_as(user)
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