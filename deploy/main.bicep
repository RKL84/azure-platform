targetScope = 'subscription'

// Parameters
@description('A short name for the workload being deployed alphanumberic only')
@maxLength(8)
param workloadName string

@description('The environment for which the deployment is being executed')
@allowed([
  'dev'
  'qa'
  'prd'
])
param environment string

param location string = deployment().location

var resourceSuffix = '${workloadName}-${environment}-001'
var networkingResourceGroupName = 'rg-networking-${resourceSuffix}'
var sharedResourceGroupName = 'rg-shared-${resourceSuffix}'
var backendResourceGroupName = 'rg-backend-${resourceSuffix}'
var apimResourceGroupName = 'rg-apim-${resourceSuffix}'

resource networkingRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: networkingResourceGroupName
  location: location
}

resource backendRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: backendResourceGroupName
  location: location
}

resource sharedRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: sharedResourceGroupName
  location: location
}

resource apimRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: apimResourceGroupName
  location: location
}

// @description('The Azure region into which the resources should be deployed.')
// param location string = resourceGroup().location

// @description('The name of the function app that you wish to create.')
// param appName string = 'azplatform'

// @description('A unique suffix to add to resource names that need to be globally unique.')
// @maxLength(13)
// param resourceNameSuffix string = uniqueString(resourceGroup().id)

// var workspaceName = 'lw-${appName}-${resourceNameSuffix}'
// var buildNumber = uniqueString(resourceGroup().id)

// module workspace 'br:acrshr0411.azurecr.io/bicep/modules/microsoft.operationalinsights.workspaces:latest' = {
//   name: 'workspacedeploy-${buildNumber}'
//   params: {
//     name: workspaceName
//     location: location
//   }
// }
