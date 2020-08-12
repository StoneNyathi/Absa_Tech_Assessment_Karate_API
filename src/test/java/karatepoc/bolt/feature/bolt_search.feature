@Regression
Feature: Returns a deal from bolts

  Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000
    * call read('config.feature') { accessToken: '#(accessToken)' }
    * def expectedOutput = read('/Users/sibusiso_yingwane/IdeaProjects/poc-karate/src/test/java/karatepoc/bolt/feature/jsonData/dealDetails.json')



  Scenario: Fetch today's deals from bolt
    Given url 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/deal/search/deal/?searchTerm=&stage=&dealer=&status=&dealType=&applicationType=&dealStatus=&startDate=2020-07-09&endDate=2020-07-09&page=0&sort=createDate,desc'
    #And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json responseJson = response
    And print responseJson
    And print '\n', response
    And match response == expectedOutput
    And match response contains {"businessReferenceNumber":"2020074930500191967"}


  @Sanity

  Scenario Outline: Fetch one specific deal
    Given path '/deal-api/api/deal/details/<BR>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json responseJson = response
    And print responseJso#And match response.businessReferenceNumber == '2020075640500191833'
    And print '\n', response

    Examples:
      | BR                  |
      | 2020075640500191880 |
      | 2020075180500191866 |
      | 2020075640500191869 |
