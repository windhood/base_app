@javascript
Feature: Change password

  Scenario: Change my password
  	Given I am signed in
  	#Then show me the page
    And I click on my name in the header
    And I follow "Account Settings"
    Then I should be on my account settings page
    When I fill in "user_password" with "newsecret"
    And I fill in "user_password_confirmation" with "newsecret"
    And I press "Change Password"
    Then I should see "Password Changed"  
    And I click on my name in the header
    And I follow "signout"
    Then I should be on the home page    
    And I sign in with password "newsecret"
    Then I should be on user root page