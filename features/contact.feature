Feature: Request a contact form

  Scenario: Request edit from home
    Given I click to edit from home Mission Creek Cafe
    Then I should see Mission Creek Cafe in the header

  Scenario: Request generic contact from home
    Given I click to contact from home Mission Creek Cafe
    Then I should not see Mission Creek Cafe in the header
