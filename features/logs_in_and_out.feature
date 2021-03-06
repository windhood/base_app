Feature: user authentication

  Scenario: user logs in
    Given a user exists with email: "ohai@test.com", password: "secret"
    When I go to the new user session page
    And I fill in "Email" with "ohai@test.com"
    And I fill in "Password" with "secret"
    And I press "Sign in"
    Then I should be on the getting started page

  @javascript
  Scenario: user logs out
    Given I am signed in
    And I click on my name in the header
    And I follow "signout"
    Then I should be on the home page