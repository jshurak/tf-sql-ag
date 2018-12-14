terraform {
  backend "azurerm" {
    storage_account_name = "tfstatejshurak"
    container_name       = "tf-state-container"
    key                  = "vm/dc.state"
    access_key           = "5dxIUoX26sKdeKq7pXcZCS1YT+kwwA3GChQmDmGFtjx7XZiVE6I2L/0lVozLmmG3PyhkyoqPns31XIuAW2q4fw=="

    resource_group_name = "tf-state-rg"
  }
}