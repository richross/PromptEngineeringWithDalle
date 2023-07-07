param name string
// param location string

//create a bicep resoucre that connects to an existing cognitive services account
resource cognitiveServicesAccount 'Microsoft.CognitiveServices/accounts@2023-05-01' existing = {
  name: name
}

//output the values needed for the configuration of the web app
output name string = cognitiveServicesAccount.name
