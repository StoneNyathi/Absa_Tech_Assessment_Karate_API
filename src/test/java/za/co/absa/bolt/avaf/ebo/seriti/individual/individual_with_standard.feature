Feature: Test finance request for individual

  Background:
    * configure ssl = true
    * url 'https://api-dev.bolt.sdc-nonprod.caas.absa.co.za/vehiclefin/services/WStoCntrlGateway'

  Scenario: Testing individual applicant for a package deal

    Given request read('resources/soap_request/standard_deal.xml')
    When soap action 'processMessage'
    Then status 200
    * print '\n', response