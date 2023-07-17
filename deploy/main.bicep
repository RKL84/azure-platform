@description('The name of the function app that you wish to create.')
param appName string = 'azplatform'

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('A unique suffix to add to resource names that need to be globally unique.')
@maxLength(13)
param resourceNameSuffix string = uniqueString(resourceGroup().id)

var workspaceName = 'lw-${appName}-${resourceNameSuffix}'
var buildNumber = uniqueString(resourceGroup().id)

module workspace 'br:acrshr0411.azurecr.io/bicep/modules/microsoft.operationalinsights.workspaces:latest' = {
  name: 'workspacedeploy-${buildNumber}'
  params: {
    name: workspaceName
    location: location
  }
}
