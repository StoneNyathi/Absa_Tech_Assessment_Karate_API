Feature: API Token

  Background:
    * configure ssl = true

  Scenario: Create token in UAT
    Given url 'https://sso.bolt.sdc-nonprod.caas.absa.co.za/auth/realms/avaf/protocol/openid-connect/token'
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

  Scenario: Create token for Credit Sanctioner in UAT
    Given url 'https://sso.bolt.sdc-nonprod.caas.absa.co.za/auth/realms/avaf/protocol/openid-connect/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field grant_type = 'password'
    And form field client_id = 'avaf'
    And form field username = 'sanctioner11'
    And form field password = 'sanctioner11'
    When method POST
    Then status 200
    * print '\n', response
    * def UAT_sactioner11_accessToken = response.access_token