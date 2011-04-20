Feature: Setup a wowo
  In order to share my trip to Bunff and show to my friends
  As a non-tech people who can use iphone/ipad/laptop/desktop
  I want to be able to setup a wowo(website) just for my trip and I want to upload my pictures, write my thoughts and update my wowo instantly.  

  @wip  
  Scenario: Choose a theme to create a wowo
    Given I am ready for creating my wowo
    And the following themes exist
    | name       | url                          | image          |
    | random 1   | /themes/random1/style.css    | random1.jpg |
    | random 2   | /themes/random2/style.css    | random2.jpg    |
  	When I follow "New WoWo"
    Then I should be on the new wowo page
    And show me the page
    And I should see "Please choose a theme"
    And I should see "random 1"
    And I should see "random 2"