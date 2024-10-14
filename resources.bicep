// variables
param appServiceName string = 'hrnkAPI'
param location string = resourceGroup().location
param skuName string = 'F1'  // Free tier
param apiAppName string = 'hrnkAPI'

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServiceName
  location: location
  sku: {
    tier: 'Free'
    name: skuName
  }
  properties: {
    reserved: false  // not Linux, for Windows
  }
}

// Web App (API hosting)
resource apiWebApp 'Microsoft.Web/sites@2022-03-01' = {
  name: apiAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
  kind: 'app'
}

// Output for app URL
output apiUrl string = 'https://${apiWebApp.defaultHostName}/'
