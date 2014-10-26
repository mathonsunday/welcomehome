@javascript
Feature: Suggest nearby homes

  Scenario: Show nearby homes when guessing
    Given a home exists in Winnipeg
    When I am in Winnipeg and I guess my location on the submission page
    Then I should see an existing home nearby

  Scenario: Show absence of nearby homes
    When I am in Winnipeg and I guess my location on the submission page
    Then I should not see an existing home nearby
