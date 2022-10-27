Given(/^I am on the home page$/) do
    visit "/"
end
  
Then(/^I should see button "(.*?)"$/) do |text|
    # page.has_text?(:visible, text, exact: true)
    find("a", :text => text)
end
  