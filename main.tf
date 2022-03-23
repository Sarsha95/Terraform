terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.49.0"
    }
  }
}

provider "azurerm" {
  features {

  }
}

resource "azurerm_resource_group" "tf" {
  name     = "terraformtest"
  location = "southcentralus"
}

resource "azurerm_container_group" "hello" {
  name                = "weatherapi"
  location            = azurerm_resource_group.tf.location
  resource_group_name = azurerm_resource_group.tf.name

  ip_address_type = "public"
  os_type         = "linux"
  dns_name_label  = "sarsha"

  container {
    name   = "weatherapi"
    image  = "sarsha1995/weatherapi"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
