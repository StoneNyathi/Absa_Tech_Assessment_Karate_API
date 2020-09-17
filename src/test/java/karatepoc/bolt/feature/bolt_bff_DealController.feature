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
    * def dates = Java.type('karatepoc.bolt.DateTime')
    * def BOR = new dates().getBusinessRefNumber("")
    * def FirstPaymentDate = new dates().getFirstPaymentDAte("")
    * def ContractStartDate = new dates().getContractStartDate("")
    * xml payload = read('karatepoc/bolt/feature/jsonData/dealDetailsUAT.xml')
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
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
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

  Scenario Outline: Get deal activity
    Given path 'api/deal/activity/<bor>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal activity for credit
    Given path 'api/deal/activity/credit/<br>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal activity
    Given path 'api/deal/activity/<bor>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal activity for credit
    Given path 'api/deal/activity/credit/<br>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal activity formatted for a deal
    Given path 'api/deal/activity/formatted/<br>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/xml;charset=utf-8'
    When method get
    Then status 200
    And print '\n', response

    Examples:
      | bor | br |
      | BOR | BR |


  Scenario Outline: Get deal contract version
    Given path 'api/deal/contract/version/<br>'
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/xml;charset=utf-8'
    When method get
    Then status 200
    And print '\n', response

    Examples:
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal details
    Given path 'api/deal/details/<br>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal indexed documents
    Given path 'api/deal/document/<br>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal status
    Given path 'api/deal/status/<br>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal summary
    Given path 'api/deal/summary/<br>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get deal tracker for deal
    Given path 'api/deal/tracker/<br>'
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
      | bor | br |
      | BOR | BR |

  Scenario Outline: Get application version
    Given path 'api/deal/version/<br>'
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
      | bor | br |
      | BOR | BR |


  Scenario Outline: Terminates a deal
    Given path 'api/deal/terminate'
    And request ({businessReferenceNumber:'<br>', terminationReason:'<terminateReason>', userComments:'<userComments>'})
    And url BOLTURL_BaseURL
    And configure connectTimeout = Timeout
    And print '######## Found saved security token ######## '+accessToken
    And header Authorization = 'Bearer '+UATaccessToken
    And header Content-Type = 'application/json'
    When method POST
    Then status 200
    And json responseJson = response
    And  print 'pretty print:', responseJson
    And print '\n', response

    Examples:
      | br | terminateReason                    | userComments              |
      | BR | Deal has some fraud related issues | Had to fix my application |

