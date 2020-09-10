@Regression
Feature: Retrives CIF data

  Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000
    * call read('config.feature') { accessToken: '#(UATaccessToken)' }

  Scenario Outline: Fetch full account profile for a specific person
    Given path '/deal-api/api/creditReferrals/customer/fullAccountProfile/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+UATaccessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json responseJson = response
    And print responseJson
    And print '######## DATA RESPONSE COMPARE #########'
    And print '\n'
    And print '\n', response

    Examples:
      | ID            |
      | 9302016305089 |