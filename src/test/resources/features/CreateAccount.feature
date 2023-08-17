@Regression
Feature: Create Account feature

  Background: Setup test and generate token.
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario: Create valid account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    #Calling Java class in feature file. this utility will create object from Java Class. 
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateDataObject.getEmail()
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "Mo",
      "lastName": "Ali",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "Student",
      "dateOfBirth": "1986-02-30"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
