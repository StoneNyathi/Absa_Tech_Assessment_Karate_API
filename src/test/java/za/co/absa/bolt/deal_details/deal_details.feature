Feature: Test Deal details capability

  Background:
    * configure ssl = true

  Scenario: Get All details for a deal details

    Given url 'https://sso-uat.bolt.sdc-nonprod.caas.absa.co.za/auth/realms/avaf/protocol/openid-connect/token'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field grant_type = 'password'
    And form field client_id = 'avaf'
    And form field username = 'avaf_bolt'
    And form field password = 'avaf_bolt'
    When method POST
    Then status 200
    * print '\n', response
    * def accessToken = response.access_token

    ## Getting deal details
    Given url 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/deal/details/2020072120500191323'
    And header authorization = 'Bearer '+ accessToken
    And header accept = '*/*'
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    * print '\n', response

    ## Getting deal activities
    Given url 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/deal/activity/formatted/2020072120500191323'
    And header authorization = 'Bearer '+ accessToken
    And header accept = '*/*'
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    * print '\n', response
