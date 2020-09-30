@Regression
  @UAT
Feature: Creates a deal and search using a business reference number then stores BR number

  Background:
    * header Content-Type = 'application/xml;charset=utf-8'
    * configure ssl = true
    * configure charset = null
    * def Timeout = 800000
    * configure charset = null
    * call read('config.feature') { accessToken: '#(UATaccessToken)' }
    * call read('config.feature') { accessToken: '#(UAT_sactioner11_accessToken)' }
    * def dates = Java.type('karatepoc.bolt.DateTime')
    * def BOR = new dates().getBusinessRefNumber("")
    * def bussRefNo = BOR
    * def FirstPaymentDate = new dates().getFirstPaymentDAte("")
    * def ContractStartDate = new dates().getContractStartDate("")
    * xml payload = read('karatepoc/bolt/feature/jsonData/dealDetailsUAT.xml')
    * replace payload.#(BOR) = BOR
    * replace payload.#(FirstPaymentDate) = FirstPaymentDate
    * replace payload.#(ContractStartDate) = ContractStartDate


  Scenario Outline: Create a deal
    When request payload
    And url GATEWAY_URL
    When method post
    Then status 200
    And print 'pretty print:', '\n', response

#  Scenario Outline: Search deal using BOR
    * configure retry = { count: 10, interval: 3000 }
    And url 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/deal/search/deal/?searchTerm=&stage=&dealer=&status=&dealType=&applicationType=&dealStatus=&errorStatus=&podiumOutcome=&startDate=&endDate=&page=0&sort=createDate,desc&reference=' + <bor>
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    And retry until response.dealSearchResults[0].businessOriginatorReferenceNumber == <bor>
    When method get
    Then status 200
    And json responseJson = response
    And print 'pretty print:', responseJson
    And assert response.dealSearchResults[0].creditStatus == "Referred"
    * def BR = response.dealSearchResults[0].businessReferenceNumber
    * print BR
    When url 'https://api.avaf-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/work/' + BR
    And header Authorization = 'Bearer '+ UAT_sactioner11_accessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And json  getResponse = response
    And print 'pretty print:', getResponse
    * def referralActionId = response.actions[0].id
    * print referralActionId
    And url 'https://api.avaf-uat.bolt.nonprod.caas.absa.co.za/deal-api/api/work/complete/'
    And header Authorization = 'Bearer '+ UAT_sactioner11_accessToken
    And header Content-Type = 'application/json'
    * json jsonPayload = read('karatepoc/bolt/feature/jsonData/creditApproval.json')
    * set jsonPayload.businessReferenceNumber = BR
    * set jsonPayload.businessOriginatorReferenceNumber = BOR
    * set jsonPayload.actionId = referralActionId
    When request jsonPayload
    And method post
    Then status 200
    And json  getResponse = response
    And print 'pretty print:', getResponse


    Examples:
      | bor |
      | BOR |