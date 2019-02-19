Feature: Create a Gist   

Background:
* url 'https://api.github.com/gists'

Scenario: Use authenticated user to create a gist

Given header Authorization = 'Basic QW5keUV4cGVyaW9yOlhUZXN0OTkh'
And request { "description":"Created via API" , "public":"true" , "files": { "file1.txt":{"content":"Demo"} } }
When method POST
Then status 201
And match $ contains {id:"#notnull"}
* print 'id is: ', response.id
* print 'url is: ', response.url
* print 'files is: ', response.files

* def file = response.files["file1.txt"]
* print 'file is: ', file
* def filename = file.filename
* def filecontent = file.content

And match filename  == "file1.txt"
And match filecontent == "Demo"
And match response.comments == 0
And match response.public == true
And match response.history[0].change_status.total == 1
