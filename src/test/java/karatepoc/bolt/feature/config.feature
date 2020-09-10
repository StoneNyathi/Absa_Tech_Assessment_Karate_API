Feature: API Token

  Background:
    * configure ssl = true

  Scenario: Create token in UAT
    Given url 'https://sso-uat.bolt.sdc-nonprod.caas.absa.co.za/auth/realms/avaf/protocol/openid-connect/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field grant_type = 'password'
    And form field client_id = 'avaf'
    And form field username = 'avaf_bolt'
    And form field password = 'avaf_bolt'
    When method POST
    Then status 200
    * print '\n', response
    * def UATaccessToken = response.access_token


  Scenario: Create token in DEV
    Given url 'https://sso.bolt.sdc-nonprod.caas.absa.co.za/auth/realms/avaf/protocol/openid-connect/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field grant_type = 'password'
    And form field client_id = 'avaf'
    And form field username = 'avaf_bolt'
    And form field password = 'avaf_bolt'
    When method POST
    Then status 200
    * print '\n', response
    * def DEVaccessToken = response.access_token