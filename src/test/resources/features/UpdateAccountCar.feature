@Regression
Feature: Updating Car account

Background: 
Given url "https://tek-insurance-api.azurewebsites.net"
* def createAccountCar = callonce read('CreateAccount.feature')
* def validToken = createAccountCar.validToken
* def generatedAccountId = createAccountCar.response.id

Scenario: Updating existing car Account

Given path "/api/accounts/add-account-car"
And header Authorization = "Bearer " + validToken
And param primaryPersonId = generatedAccountId
And request 
"""
{
  
  "make": "Toyota",
  "model": "RAVA4",
  "year": "2022",
  "licensePlate": "ABC-234"
}
"""
When method post
Then status 201
And print response
And assert response.make == "Toyota"
And assert response.year == "2022"

* def carId = response.id
#updating car
And path "/api/accounts/update-account-car"
And header Authorization = "Bearer " + validToken
And param primaryPersonId = generatedAccountId
And request 
"""
{
"id": "#(carId)",
   "make": "Toyota",
  "model": "Camrey",
  "year": "2024",
  "licensePlate": "ABC-236"
}
"""
When method put
Then status 202
And print response
And assert response.make == "Toyota"
And assert response.year == "2024"


