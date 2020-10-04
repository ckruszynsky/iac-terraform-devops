provider "azurerm" {
  version = "2.5.0"
  features {}
}

terraform {
  backend "azurerm" {
    subscription_id      = "9965be60-5b04-4755-8a13-c62d92f8a196"
    resource_group_name  = "tf_rg_blob"
    storage_account_name = "tfstoreckruszy"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

variable "imagebuild" {
  type        = string
  description = "Latest Image Build"
}

resource "azurerm_resource_group" "terraform_test" {
  name     = "tf_resource_grp"
  location = "South Central US"
}

resource "azurerm_container_group" "tfcg_test" {
  name                = "tf_weatherapi"
  location            = azurerm_resource_group.terraform_test.location
  resource_group_name = azurerm_resource_group.terraform_test.name
  ip_address_type     = "public"
  dns_name_label      = "ckruszynskyweatherapitf"
  os_type             = "Linux"

  container {
    name   = "weatherapi"
    image  = "ckruszynsky/weatherapi:${var.imagebuild}"
    cpu    = "1"
    memory = "1"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }
}


