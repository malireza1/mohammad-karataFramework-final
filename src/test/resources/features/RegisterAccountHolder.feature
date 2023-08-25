@Regression
Feature: Register new Account

Background: setup test new account 
Given url "https://tek-insurance-api.azurewebsites.net"
* def createAccountR = callonce read('CreateAccount.feature')
* def accountId = createAccountR.response.id
* def fullName = createAccountR.response.firstName + " " + createAccountR.response.lastName


Scenario: Sign up register new user
Given path "/api/sign-up/register"
* def dataGenerator = Java.type('api.utility.data.GenerateData')
* def auto_username = dataGenerator.getUsername()
And request
"""
{
  "primaryPersonId": "#(accountId)",
  "fullname": "fullName",
  "username": "#(auto_username)",
  "password": "Mali143@",
  "authority": "CUSTOMER",
  "accountType": "CUSTOMER"
}
"""
When method post
Then print response
Then status 201
And assert response.username == auto_username
