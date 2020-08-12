Feature: Returns a deals from bolt

  Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000
    * call read('config.feature') { accessToken: '#(accessToken)' }

  Scenario Outline: Getting specific deal details
    Given path 'api/deal/details/<br>'
    And url BOLTURL_BaseURL
    And header authorization = 'Bearer '+ accessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    * print '\n', response

    Examples:
      | br                  |
      | 2020073580500191828 |
      | 2020075310500191818 |

