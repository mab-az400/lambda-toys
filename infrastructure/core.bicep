param location array
param prefix string

param vnetSettings object = {
  addressPrefixes: [
    '10.0.0.0/20'
  ]
  sunets: [
    {
      name: 'subnet1'
      addressPrefixes: '10.0.0.0/20'
    }
  ]
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: '${prefix}-default-nsg'
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}



resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: '${prefix}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: vnetSettings.addressPrefixes
    }
    subnets: [ for subnet in vnetSettings.subnets:{
      name: subnet.name
      properties:{
        addressPrefix:subnet.adressPrefix
        networkSecurityGroup: networkSecurityGroup

      }
    }]
  }
}

