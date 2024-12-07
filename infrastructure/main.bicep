param location string = 'Poland Central'
@allowed(['dev', 'qa'])
param environment string

targetScope = 'resourceGroup'

module app './appservice.bicep' = {
  name: 'appservice'
  params: {
    appName: 'github-actions-demo'
    environment: environment
    location: location
  }
}