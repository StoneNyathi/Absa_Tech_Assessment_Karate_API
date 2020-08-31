Feature: Creates a deal and search using a business reference number

  Background:
    * header Content-Type = 'application/xml;charset=utf-8'
    * configure ssl = true
    * configure charset = null
    * def Timeout = 800000
    * configure charset = null
    * call read('config.feature') { accessToken: '#(accessToken)' }
    * def dates = Java.type('karatepoc.bolt.DateTime')
    * def BOR = new dates().getBusinessRefNumber("")
    * def FirstPaymentDate = new dates().getFirstPaymentDAte("")
    * def ContractStartDate = new dates().getContractStartDate("")
    * xml payload = read('karatepoc/bolt/feature/jsonData/dealDetails.xml')
    * replace payload.#(BOR) = BOR
    * replace payload.#(FirstPaymentDate) = FirstPaymentDate
    * replace payload.#(ContractStartDate) = ContractStartDate


  Scenario: Create a deal
    When request payload
    And url GATEWAY_URL
    When method post
    Then status 200
    And print 'pretty print:', '\n', response

  Scenario Outline: Search deal using BOR
    Given url 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/deal/search/deal/?searchTerm=&stage=&dealer=&status=&dealType=&applicationType=&dealStatus=&errorStatus=&podiumOutcome=&startDate=&endDate=&page=0&sort=createDate,desc&reference=<bor>'
    #And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json responseJson = response
    And  print 'pretty print:', responseJson
    And print '\n', response
    And assert response.dealSearchResults[0].creditStatus == "Referred"
    * def BR = response.dealSearchResults[0].businessReferenceNumber
    * print BR

    Examples:
      | bor |
      | BOR |