param name string
param location string
param tags object = {}


//create an app service plan in bicep
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

output appServicePlanId string = appServicePlan.id
output appServicePlanName string = appServicePlan.name
