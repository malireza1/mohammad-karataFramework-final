@Smoke
Feature: Security Token Test

Background: setup test
Given url "https://tek-insurance-api.azurewebsites.net"
Then path "/api/token"

Scenario: Generate valid token with valid username and password
# prepar request
And request {"username": "supervisor","password": "tek_supervisor"}
When method post
Then status 200
And print response

Scenario Outline: Validate token with invalid username
And request
"""
{
  "username": "<username>",
  "password": "<password>"
}
"""
When method post
Then status 400
And print response
And assert response.errorMessage == "<errorMessage>" 

Examples:
| username  | password      | errorMessage        |
| wronuser  | tek_supervisor| User not found      |
| supervisor| wrongpass     | Password Not Matched|




