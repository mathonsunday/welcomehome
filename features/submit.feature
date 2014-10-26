@javascript
Feature: Submit a home

  Scenario: Submit a home manually
    When I submit a home in Vancouver
    Then I should see that the home has been created
