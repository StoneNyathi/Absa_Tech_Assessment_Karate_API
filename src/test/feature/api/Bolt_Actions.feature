Feature: Returns a deal from bolts

  Background:
    * url 'https://restcountries.eu'
    * header Accept = 'application/json'
    * configure ssl = true

  Scenario: Return all deals from Bolt
    Given path '/rest/v2/all'
    When method GET
    And print responce
    Then status 200