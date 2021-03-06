Feature: Create and Update a Gist  

Background:
* url 'https://api.github.com/gists'

Scenario: Use authenticated user to create a gist and then update it

Given header Authorization = 'Basic QW5keUV4cGVyaW9yOlhUZXN0OTkh'
And request { "description":"Created via API" , "public":"true" , "files": { "file1.txt":{"content":"Demo"} } }
When method POST
Then status 201
And match $ contains {id:"#notnull"}
* print 'id is: ', response.id
* def gistid = response.id
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
And match response.history[0].change_status.additions == 1

Given path gistid
Given header Authorization = 'Basic QW5keUV4cGVyaW9yOlhUZXN0OTkh'
And request { "description":"Created via API" , "public":"true" , "files": { "file1.txt":{"content":"Updated File Contents"} } }
When method PATCH
* def updatedfile = response.files["file1.txt"]
* def updatedfilecontent = updatedfile.content
* print 'updatedfile is: ', updatedfile
And match updatedfilecontent == "Updated File Contents"
And match response.history[0].change_status.total == 2
And match response.history[0].change_status.additions == 1
And match response.history[0].change_status.deletions == 1

