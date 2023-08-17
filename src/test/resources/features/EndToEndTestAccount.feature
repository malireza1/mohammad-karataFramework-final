@endToEndTest
Feature: Create an Account

Background: Setup Test Create an Account

Given url "https://tek-insurance-api.azurewebsites.net"
* def endToEndAccount = callonce read('CreateAccount.feature')
And print endToEndAccount 
* def validToken = endToEndAccount.validToken
* def createAccountId = endToEndAccount.response.id

Scenario: Add Address and Phone And Car to Account
And path "/api/accounts/add-account-address"
And param primaryPersonId = createAccountId
And header Authorization = "Bearer " + validToken
And request 
"""
{
 
  "addressType": "Home",
  "addressLine1": "111 first st",
  "city": "San francisco",
  "state": "CA",
  "postalCode": "99559",
  "countryCode": "+1",
  "current": true
}
"""
When method post
Then status 201
And print response

Given path "/api/accounts/add-account-car"
* def plateGenerator = Java.type('api.utility.data.GenerateData')
* def licensPlate = plateGenerator.getLicensePlate()
And param primaryPersonId = createAccountId
And header Authorization = "Bearer " + validToken
And request
"""
{

  "make": "Toyota",
  "model": "Corolla",
  "year": "2022",
  "licensePlate": "#(licensPlate)"
}
"""
When method post
Then status 201
And print response

Given path "/api/accounts/add-account-phone"
And param primaryPersonId = createAccountId
And header Authorization = "Bearer " + validToken
* def dataGenerator = Java.type('api.utility.data.GenerateData')
* def phoneNumber = dataGenerator.getPhoneNumber()
And request
"""
{
  
  "phoneNumber": "#(phoneNumber)",
  "phoneExtension": "",
  "phoneTime": "Noon",
  "phoneType": "CellPhone"
}
"""
When method post
Then status 201
And assert response.phoneNumber == phoneNumber

Given path "/api/accounts/delete-account"
And param primaryPersonId = createAccountId
And header Authorization = "Bearer " + validToken
When method delete
Then status 200
And print response == "Account Successfully deleted"


