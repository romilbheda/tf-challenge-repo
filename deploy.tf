# Cofigure the Azure provider 
provider "azurerm" {
    version = "~>2.0"
    features {}
}

# Create Resource Group
resource "azurerm_resource_group" "my_resource_group" {
    name = "tf-challenge-rg"
    location = "southeastasia"
}

# Create App Service Plan
resource "azurerm_app_service_plan" "my_serviceplan" {
    name = "my-service-plan"
    resource_group_name = "${azurerm_resource_group.my_resource_group.name}"
    location = "${azurerm_resource_group.my_resource_group.location}"

    sku {
        tier = "Standard"
        size = "S1"
    }
}

variable "deployment_name" {
    type = "string"
}

# Create Web App
resource "azurerm_app_service" "my_website" {
    name = "${var.deployment_name}-web"
    location = "${azurerm_resource_group.my_resource_group.location}"
    app_service_plan_id = "${azurerm_app_service_plan.my_serviceplan.id}"
    resource_group_name = "${azurerm_resource_group.my_resource_group.name}"
}