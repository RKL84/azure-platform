targetScope = 'resourceGroup'
// Parameters
@description('Azure location to which the resources are to be deployed')
param location string

@description('Required. The naming module for facilitating naming convention.')
param naming object

@description('Optional. The tags to be assigned to the created resources.')
param tags object = {}

var resourceNames = {
  keyVault: naming.keyVault.nameUnique
  applicationInsights: naming.applicationInsights.name
  logAnalyticsWorkspace: naming.logAnalyticsWorkspace.name
}

module keyVaultModule './keyVault.bicep' = {
  name: 'keyvault-Deployment'
  params: {
    location: location
    name: resourceNames.keyVault
    tags: tags
  }
}

output keyVaultName string = keyVaultModule.name
