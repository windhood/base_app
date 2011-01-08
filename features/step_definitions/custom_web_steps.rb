When /^(.*) in the header$/ do |action|
  within('header') do
    When action
  end
end

When /^(.*) in the modal window$/ do |action|
  within('#fancybox-wrap') do
    When action
  end
end

Then /^I should see "([^\"]*)" in the main content area$/ do |stuff|
  within("#main_stream") do
    Then "I should see #{stuff}"
  end
end

When /^I wait for the dashboard page to load$/ do
  wait_until { current_path == user_root_path }
end

When /^I wait for the ajax to finish$/ do
  wait_until { evaluate_script("$.active") == 0 }
end
