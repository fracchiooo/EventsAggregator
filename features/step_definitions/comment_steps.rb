require 'capybara/rails'

When(/^visita la pagina del primo evento/) do
    first("a", :text => 'apri l\'evento').click
end

When(/^scrive un commento/) do
    fill_in 'comment[testo]', with: 'Valutazione di prova'
end

When(/^clicca il bottone commenta/) do
    click_button 'Commenta'
end

When(/^legge il proprio commento/) do 
    find("p", :text => 'Valutazione di prova')
end

When(/^clicca il pulsante elimina/) do 
    first("button", :text => 'Elimina').click
end

Then(/^non legge più il commento/) do
    expect(page.has_css?('#comment_1', wait: 3)).to eq false
end