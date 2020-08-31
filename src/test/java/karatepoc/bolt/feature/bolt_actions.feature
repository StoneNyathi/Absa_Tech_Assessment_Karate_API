Feature: Returns a deal from bolts

  Background:
    * url 'https://restcountries.eu'
    * header Accept = 'application/json'
    * configure ssl = true
    * def dates = Java.type('karatepoc.bolt.DateTime')
    * def BOR = new dates().getBusinessRefNumber("")
    * def FirstPaymentDAte = new dates().getFirstPaymentDAte("")
    * def ContractStartDate = new dates().getFullDate("")

  Scenario: Return all deals from Bolt
    And print '===============|||BOR|||=============\n', BOR
    And print '\n'
    And print '===============|||FirstPaymentDAte|||=============\n', FirstPaymentDAte
    And print '\n'
    And print '===============|||ContractStartDate|||=============\n', ContractStartDate
    And print '\n'
    Given path '/rest/v2/all'
    And print '============================\n', getTimeStamp
    #When method GET
    #And json responseJson = response
   # And print responseJson
    #And assert getResponseParam('creditStatus') == query.name
    #And assert getResponseParam('country') == query.country
    #And assert getResponseParam('active') == query.active
    #And assert getResponseParam('limit') == query.limit
    #Then status 200