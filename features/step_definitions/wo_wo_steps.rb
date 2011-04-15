Given /^I am ready for creating my wowo$/ do
  Given 'I am signed in'
  And 'I am on my wowos page'
end

When /^I click on my name$/ do
  click_link("#{@me.display_name}")
end