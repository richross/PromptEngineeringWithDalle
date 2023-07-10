param name string
param location string
param tags object = {}
param appServicePlanId string
param cogServAccountName string
param cogServResourceGroupName string

//create a bicep resoucre that connects to an existing cognitive services account
resource cognitiveServicesAccount 'Microsoft.CognitiveServices/accounts@2023-05-01' existing = {
  name: cogServAccountName
  scope: resourceGroup(cogServResourceGroupName)
}

//create the app settings for the app service
var appSettings = {
  'AzureOpenAIResourceName': cognitiveServicesAccount.name
  'AzureOpenAIResourceKey': cognitiveServicesAccount.listKeys().key1
}

//create an appservice config appsettings object, include the reference to the parent object
resource appServiceSettings 'Microsoft.Web/sites/config@2022-09-01' = {
  parent: appService
  name: 'appsettings'
  kind: 'string'
  properties: appSettings
}

//create an app service resource using bicep
resource appService 'Microsoft.Web/sites@2022-09-01' = {
  name: name
  location: location
  tags: union(tags, {'azd-service-name': 'web'})
  kind: 'app'
  properties: {
    serverFarmId: appServicePlanId
  }
}

output appServiceName string = appService.name
output appServiceId string = appService.id
