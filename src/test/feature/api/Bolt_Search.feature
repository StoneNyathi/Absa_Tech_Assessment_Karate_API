Feature: Returns a deal from bolts

  Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000
    * call read('config.feature') { accessToken: '#(accessToken)' }

  Scenario: Fetch all deals from bolt
    Given url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json responseJson = response
    And print responseJson
    #And match response.businessReferenceNumber == '2020075640500191833'
    And print '\n', response



  Scenario Outline: Getting specific deal details
    Given path 'api/deal/details'+ br
    And header authorization = 'Bearer '+ accessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    * print '\n', response

    Examples:
      | br                  |
      | 2020073580500191828 |
      | 2020075310500191818 |

  Scenario: Getting deal details
    Given url 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/deal/activity/formatted/2020072120500191323'
    And header authorization = 'Bearer '+ accessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    * print '\n', response


