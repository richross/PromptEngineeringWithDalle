param name string
param location string
param tags object = {}
param appServicePlanId string
param appSettings object = {}

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
