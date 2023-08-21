targetScope = 'resourceGroup'
// Parameters
@description('Azure location to which the resources are to be deployed')
param location string

@description('The environment for which the deployment is being executed')
@allowed([
  'dev'
  'qa'
  'prd'
])
param environment string

// Parameters
@description('A short name for the workload being deployed alphanumberic only')
@maxLength(8)
param workloadName string

@description('The name of the shared resource group')
param resourceGroupName string

@description('Standardized suffix text to be added to resource names')
param resourceSuffix string

@description('Storage Account type')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
])
param storageAccountType string = 'Standard_LRS'

var storageAccountName = 'st${workloadName}${environment}01'
var keyVaultName = take('kv-${resourceSuffix}', 24)
var buildNumber = uniqueString(resourceGroup().id)

module storageAccounts 'br:acrshr0411.azurecr.io/bicep/modules/microsoft.storage.storageaccounts:latest' = {
  name: 'stvmdeploy-${buildNumber}'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: storageAccountName
    storageAccountSku: storageAccountType
    location: location
  }
}

module keyVaultModule 'br:acrshr0411.azurecr.io/bicep/modules/microsoft.keyvault.vaults:latest' = {
  name: 'kvdeploy-${buildNumber}'
  scope: resourceGroup(resourceGroupName)
  params: {
    name: keyVaultName
    location: location
    vaultSku: 'standard'
  }
}

output keyVaultName string = keyVaultModule.name
output storageAccountName string = storageAccounts.name
