@Regression
@DEV
Feature: Document Controller

  Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000
    * call read('config.feature') { accessToken: '#(DEVaccessToken)' }

  Scenario: chequeConduct
    Given path '/api/creditReferrals/customer/chequeConduct'
    And url BFF_BaseURL
    And configure connectTimeout = Timeout
    And param accNumber = '<accNumber>'
    And param branchCode = '<branchCode>'
    And header Authorization = 'Bearer '+DEVaccessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print '\n'
    And json responseJson = response