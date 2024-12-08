param appName string
@allowed(['dev', 'qa'])
param environment string
param location string
var skuName = (environment == 'dev') ? 'F1' : 'S1'

var appServiceProperties = {
  serverFarmId: appServicePlan.id
  httpsOnly: true
  siteConfig: {
    linuxFxVersion: 'DOTNETCORE|8.0'
    ftpsState: 'Disabled'
    minTlsVersion: '1.2'
    http20Enabled: environment == 'qa'
    alwaysOn: environment == 'qa'
    webSocketsEnabled: environment == 'qa'
    requestTracingEnabled: environment == 'qa'
    detailedErrorLoggingEnabled: environment == 'qa'
    httpLoggingEnabled: environment == 'qa'
    healthCheckPath: '/api/health'
  }
}


resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'asp-${appName}-${environment}'
  location: location
  sku: {
    name: skuName
  }
  kind: 'linux'
  properties: {
    reserved: environment == 'qa'
  }
}

resource appService 'Microsoft.Web/sites@2022-09-01' = {
  name: 'app-${appName}-${environment}'
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: appServiceProperties
}

resource appSettings 'Microsoft.Web/sites/config@2022-09-01' = {
  name: 'appsettings'
  kind: 'string'
  parent: appService
  properties: {
    ASPNETCORE_ENVIRONMENT: environment
  }
}

resource appServiceSlot 'Microsoft.Web/sites/slots@2022-09-01' = {
  location: location
  parent: appService
  name: 'slot'
  identity: {
    type: 'SystemAssigned'
  }
  properties: appServiceProperties
}

resource appServiceSlotSetting 'Microsoft.Web/sites/slots/config@2022-09-01' = {
  name: 'appsettings'
  kind: 'string'
  parent: appServiceSlot
  properties: {
    ASPNETCORE_ENVIRONMENT: environment
  }
}