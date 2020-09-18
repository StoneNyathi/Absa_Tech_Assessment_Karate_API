@Regression
  @UAT
Feature: Retrives CIF data

  Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000
    * call read('config.feature') { accessToken: '#(UATaccessToken)' }
    * def expectedChequeConductOutput = read('karatepoc/bolt/feature/jsonData/cifRefChequeConduct.json')
    * def expectedCustomerAccountOverviewOutput = read('karatepoc/bolt/feature/jsonData/cifRefOverview.json')
    * def expectedChequeGroupExposure = read('karatepoc/bolt/feature/jsonData/cifRefGroupExposure.json')

  Scenario Outline: Fetch customer overview cif data for a specific person
    Given path '/api/creditReferrals/customer/accountOverview/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method get
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And print '\n'
    And json responseJson = response
    And print responseJson
    And print '\n', response

    Examples:
      | ID            |
      | 7510120055083 |


  Scenario Outline: Fetch group exposure for a specific person
    Given path '/api/creditReferrals/customer/groupExposure/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
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
    Given path '/api/creditReferrals/customer/fullAccountProfile/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
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


  Scenario Outline: Fetch customer cheque conduct
    Given path '/api/creditReferrals/customer/chequeConduct'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And param accNumber = '<accNumber>'
    And param branchCode = '<branchCode>'
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And  print 'pretty print:', responseJson
    #And match expectedChequeConductOutput == response

    Examples:
      | accNumber  | branchCode |
      | 4047969653 | 8198       |


  Scenario Outline: Fetch customer overview
    Given path '/api/creditReferrals/customer/accountOverview/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And  print 'pretty print:', responseJson
    #And match expectedCustomerAccountOverviewOutput == response

    Examples:
      | ID            |
      | 7510120055083 |

  Scenario Outline: Fetch CIF Keys
    Given path '/api/creditReferrals/customer/cifKeys/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And  print 'pretty print:', response

    Examples:
      | ID            |
      | 7510120055083 |


  Scenario Outline: Fetch all customer accounts
    Given path '/api/creditReferrals/customer/fullAccountProfile/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And  print 'pretty print:', responseJson

    Examples:
      | ID            |
      | 7510120055083 |


  Scenario Outline: Fetch customer group exposure
    Given path '/api/creditReferrals/customer/groupExposure/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And  print 'pretty print:', responseJson

    Examples:
      | ID            |
      | 7510120055083 |

  Scenario Outline: Fetch customer risk grade
    Given path '/api/creditReferrals/customer/riskGrade/<ID>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And  print 'pretty print:', responseJson

    Examples:
      | ID            |
      | 7510120055083 |

  Scenario Outline: Fetch customer savings conduct
    Given path 'api/creditReferrals/customer/savingsConduct'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And param accNumber = '<accNumber>'
    And param branchCode = '<branchCode>'
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method GET
    Then status 200
    And print '######## DATA RESPONSE COMPARE #########'
    And  print 'pretty print:', responseJson

    Examples:
      | accNumber  | branchCode |
      | 4047969653 | 8198       |

