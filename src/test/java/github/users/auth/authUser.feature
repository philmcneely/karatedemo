Feature: Get authenticated user info    

Background:
* url 'https://api.github.com/users'

Scenario: get authenticated user information and verify private data is shown  e5d2ba85f20052877ebb2f603d475731f5269628

Given path 'AndyExperior'
Given header Authorization = 'Basic QW5keUV4cGVyaW9yOlhUZXN0OTkh'
When method get
Then status 200
And match response.id contains 36721399
And match response.total_private_repos  == 0
* print 'id is: ', response.id
* print 'total_private_repos is: ', response.total_private_repos