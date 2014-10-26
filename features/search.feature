@javascript
Feature: Search for homes

  Scenario: Text search from splash page
    Given a home exists in Winnipeg
    When I am on the splash page
    And I search for "Winnipeg"
    Then I should see a home

  Scenario: Location search from splash page
    Given a home exists in Winnipeg
    When I am on the splash page
    And I search from Vancouver
    Then I should not see a home

  Scenario: Map display
    Given a home exists in Winnipeg
    When I am on the splash page
    And I search from Winnipeg
    And I show the map
    Then I should see a home on the map
