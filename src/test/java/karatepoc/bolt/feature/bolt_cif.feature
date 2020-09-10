@Regression
Feature: Retrives CIF data

  Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000
    * call read('config.feature') { accessToken: '#(accessToken)' }
    * def expectedOutput = read('karatepoc/bolt/feature/jsonData/cifOverview.json')
   # * def expectedOutputII = read('/src/test/java/karatepoc/bolt/feature/jsonData/cifGoupExposure.json')

  Scenario Outline: Fetch customer overview cif data for a specific person
    Given path '/deal-api/api/creditReferrals/customer/accountOverview/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And print '\n'
    And json responseJson = response
    And match responseJson == expectedOutput
    And print responseJson
    And print '\n', response

    Examples:
      | ID            |
      | 7510120055083 |


  Scenario Outline: Fetch group exposure for a specific person
    Given path '/deal-api/api/creditReferrals/customer/groupExposure/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json responseJson = response
    And print responseJson
    And print '######## DATA RESPONSE COMPARE #########'
    And print '\n'
    #And match expectedOutputII == responseJson
    And print '\n', response

    Examples:
      | ID            |
      | 3803019117001 |

  Scenario Outline: Fetch full account profile for a specific person.
    Given path '/deal-api/api/creditReferrals/customer/fullAccountProfile/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+accessToken
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


