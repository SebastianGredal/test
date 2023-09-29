{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "subscriptionId": {
            "type": "string"
        },
        "name": {
            "type": "string"
        },
        "location": {
            "type": "string"
        },
        "environmentId": {
            "type": "string"
        },
        "containers": {
            "type": "array"
        },
        "secrets": {
            "type": "secureObject",
            "defaultValue": {
                "arrayValue": []
            }
        },
        "registries": {
            "type": "array"
        },
        "ingress": {
            "type": "object"
        },
        "environmentName": {
            "type": "string"
        },
        "workspaceName": {
            "type": "string"
        },
        "workspaceLocation": {
            "type": "string"
        }
    },
    "resources": [
        {
            "apiVersion": "2023-04-01-preview",
            "name": "[parameters('name')]",
            "type": "Microsoft.App/containerapps",
            "kind": "containerapps",
            "location": "[parameters('location')]",
            "dependsOn": [
                "[concat('Microsoft.App/managedEnvironments/', parameters('environmentName'))]"
            ],
            "properties": {
                "environmentId": "[parameters('environmentId')]",
                "configuration": {
                    "secrets": "[parameters('secrets').arrayValue]",
                    "registries": "[parameters('registries')]",
                    "activeRevisionsMode": "Single",
                    "ingress": "[parameters('ingress')]"
                },
                "template": {
                    "containers": "[parameters('containers')]",
                    "scale": {
                        "minReplicas": 1,
                        "maxReplicas": 1
                    }
                }
            }
        },
        {
            "apiVersion": "2023-04-01-preview",
            "name": "[parameters('environmentName')]",
            "type": "Microsoft.App/managedEnvironments",
            "location": "[parameters('location')]",
            "dependsOn": [],
            "properties": {
                "appLogsConfiguration": {
                    "destination": null,
                    "logAnalyticsConfiguration": null
                },
                "vnetConfiguration": {
                    "infrastructureSubnetId": "/subscriptions/a8a5d9c0-b8c1-42bf-8918-0f914cc33097/resourceGroups/rg-api-simulator-apisimulator-t/providers/Microsoft.Network/virtualNetworks/vnet-api-simulator-apisimulator-t/subnets/snet-api-simulator-apisimulator-t",
                    "internal": false
                },
                "zoneRedundant": false
            }
        }
    ]
}