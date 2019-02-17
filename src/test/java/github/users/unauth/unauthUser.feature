Feature: Get unauthenticated user info    

Background:
* url 'https://api.github.com/users'

Scenario: get unauthenticated user information and verify private data not shown

Given path 'AndyExperior'
When method get
Then status 200
And match response.id contains 36721399
And match response.total_private_repos  == '#notpresent'
* print 'id is: ', response.id