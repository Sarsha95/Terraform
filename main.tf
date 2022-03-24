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

terraform {
  backend "azurerm" {
    resource_group_name   =  "terraformtest"
    storage_account_name =  "tfstoragehelloaks1995"
    container_name        =  "tfcontainer"
    key                   =  "terraform.tfstate"
  }
}

variable "imagebuild" {
  type          =   string
  description   =   "Image build"
}

resource "azurerm_resource_group" "tf" {
  name     = "terratest"
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
    image  = "sarsha1995/weatherapi:${var.imagebuild}"
    cpu    = "1"
    memory = "1"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}
