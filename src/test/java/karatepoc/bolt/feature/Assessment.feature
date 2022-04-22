@Regression
Feature: Breeds

    Background:
    * header Accept = 'application/json'
    * configure ssl = true
    * def Timeout = 800000

        Scenario: LIST ALL BREEDS
            Given path '/list/all'
              And url URL_BaseURL
              And configure connectTimeout = Timeout
             When method GET
             Then status 200
              And print '######## DATA RESPONSE COMPARE #########'
              And json responseJson = response
              And print 'pretty print:', responseJson
              And assert response.status == "success"
              And assert response.message.length > 0

        Scenario: VERIFY RETRIEVER BREED
            Given path '/list/all'
              And url URL_BaseURL
              And configure connectTimeout = Timeout
             When method GET
             Then status 200
              And json responseJson = response
              And print 'pretty print:', responseJson
              And def expectedValue = retriever: ["chesapeake","curly","flatcoated","golden"];
              And match response.message.retriever contains expectedValue

        Scenario: SUB-RETRIEVER BREED
            Given path '/list/all'
              And url URL_BaseURL
              And configure connectTimeout = Timeout
             When method GET
             Then status 200
              And json responseJson = response
              And print 'pretty print:', responseJson
              And match response.message.retriever contains ["chesapeake","curly","flatcoated","golden"];

        Scenario: RANDOM IMAGES
            Given path '/image/random/'
              And url URL_BaseURL
              And configure connectTimeout = Timeout
             When method GET
             Then status 200
              And json responseJson = response
              And print 'pretty print:', responseJson
