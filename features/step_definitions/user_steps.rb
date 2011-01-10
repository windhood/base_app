Given /^a user with email "([^\"]*)" and password "([^\"]*)"$/ do |username, password|
  Factory(:user, :email       => email, :password => password,
          :password_confirmation => password, :getting_started => false)
end

When /^I click on my name$/ do
  click_link("#{@me.display_name}")
end