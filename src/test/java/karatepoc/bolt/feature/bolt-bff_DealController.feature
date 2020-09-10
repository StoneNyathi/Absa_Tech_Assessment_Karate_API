@Regression
@DEV
Feature: Deal Controller

  Background:
    * header Content-Type = 'application/xml;charset=utf-8'
    * configure ssl = true
    * configure charset = null
    * def Timeout = 800000
    * configure charset = null
    * call read('config.feature') { accessToken: '#(DEVaccessToken)' }
    * def dates = Java.type('karatepoc.bolt.DateTime')
    * def BOR = new dates().getBusinessRefNumber("")
    * def FirstPaymentDate = new dates().getFirstPaymentDAte("")
    * def ContractStartDate = new dates().getContractStartDate("")
    * xml payload = read('karatepoc/bolt/feature/jsonData/dealDetailsDEV.xml')
    * replace payload.#(BOR) = BOR
    * replace payload.#(FirstPaymentDate) = FirstPaymentDate
    * replace payload.#(ContractStartDate) = ContractStartDate


  Scenario: Create a deal
    When request payload
    And print ' BOR : \n',  BOR
    And url GATEWAY_URL_DEV
    When method post
    Then status 200
    And print 'pretty print:', '\n', response

  Scenario Outline: Search deal using BOR
    Given url 'https://api.avaf-dev.bolt.nonprod.caas.absa.co.za/deal-api/api/deal/details/2020095160129092332'
    #And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+DEVaccessToken
    And header Content-Type = 'application/xml;charset=utf-8'
    When method get
    Then status 200
    And json responseJson = response
    And  print 'pretty print:', responseJson
    And print '######## DATA RESPONSE COMPARE #########'
    And  print 'pretty print:', response
    And assert response.dealSearchResults[0].creditStatus == "Approved"
    * def BR = response.dealSearchResults[0].businessReferenceNumber
    * print BR
#https://api.avaf-dev.bolt.nonprod.caas.absa.co.za/
    Examples:
      | bor |
      | BOR |