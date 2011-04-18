Feature: Setup a wowo
  In order to share my trip to Bunff and show to my friends
  As a non-tech people who can use iphone/ipad/laptop/desktop
  I want to be able to setup a wowo(website) just for my trip and I want to upload my pictures, write my thoughts and update my wowo instantly.  

  @wip  
  Scenario: Create a wowo and go through the setup wizard
  	Given I am ready for creating my wowo
  	When I follow "New WoWo"
    Then I should be on the new wowo page
    #And show me the page
    And I should see "Please choose a theme"