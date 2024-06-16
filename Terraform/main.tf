
resource "azurerm_resource_group" "cantaso_rg" {
  name     = "cantasoresourcegroup"
  location = "North Europe"
}

resource "azurerm_service_plan" "cantaso_sp" {
  name                = "cantasosp"
  resource_group_name = azurerm_resource_group.cantaso_rg.name
  location            = azurerm_resource_group.cantaso_rg.location
  os_type             = "Linux"
  sku_name            = "F1"
}


resource "azurerm_linux_web_app" "cantaso_wa" {
  name                = "cantasowebapp"
  resource_group_name = azurerm_resource_group.cantaso_rg.name
  location            = azurerm_service_plan.cantaso_sp.location
  service_plan_id     = azurerm_service_plan.cantaso_sp.id

  site_config {
    always_on     = false
    http2_enabled = true
  }


  tags = {
    environment = "development"
    owner       = "Betheval"
  }
}
