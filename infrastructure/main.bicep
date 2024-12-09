param location string = 'Poland Central'

// only 'dev' and 'qa' values are allowed as 'environment' values
@allowed(['dev', 'qa'])
param environment string

// means that all resources defined in this Bicep script are intended to be deployed
// within a specific resource group in Azure
targetScope = 'resourceGroup'

module app './appservice.bicep' = {
  name: 'appservice'
  params: {
    appName: 'github-actions-demo'
    environment: environment
    location: location
  }
}