@Regression
  @UAT
Feature: Returns a deal from bolts

  Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000
    * call read('config.feature') { accessToken: '#(UATaccessToken)' }

  Scenario Outline: Fetch one specific deal
    Given path '/api/deal/details/<BR>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json responseJson = response
    And  print 'pretty print:', responseJson
    And print '\n', response

    Examples:
      | BR                  |
      | 2020075640500191880 |
      | 2020075180500191866 |
      | 2020075640500191869 |

    
  Scenario: Fetch today's deals from bolt
    Given url 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/deal/search/deal/?searchTerm=&stage=&dealer=&status=&dealType=&applicationType=&dealStatus=&startDate=2020-07-09&endDate=2020-07-09&page=0&sort=createDate,desc'
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json responseJson = response
    And print responseJson
    And print '\n', response
    And print responseJso#And match response.businessReferenceNumber == '2020075640500191833'
    And print '\n', response

