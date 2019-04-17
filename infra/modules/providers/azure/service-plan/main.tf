resource "azurerm_resource_group" "svcplan" {
  name     = "${var.resource_group_name}"
  location = "${var.resource_group_location}"
}

resource "azurerm_app_service_plan" "svcplan" {
  name                = "${var.svcplan_name}"
  location            = "${azurerm_resource_group.svcplan.location}"
  resource_group_name = "${azurerm_resource_group.svcplan.name}"
  kind                = "${var.svcplan_kind}"

  sku {
    tier = "${var.svcplan_tier}"
    size = "${var.svcplan_size}"
  }
}

resource "azurerm_app_service" "appsvc" {
  name                = "${var.appsvc_name}"
  location            = "${azurerm_resource_group.svcplan.location}"
  resource_group_name = "${azurerm_resource_group.svcplan.name}"
  app_service_plan_id = "${azurerm_app_service_plan.svcplan.id}"
}

resource "azurerm_public_ip" "appsvc" {
  name                = "${var.publicip_name}"
  resource_group_name = "${azurerm_resource_group.svcplan.name}"
  location            = "${azurerm_resource_group.svcplan.location}"
  allocation_method   = "${var.pubip_alloc_method}"
}

resource "azurerm_lb" "appsvc" {
  name                = "${var.lb_name}"
  location            = "${azurerm_resource_group.svcplan.location}"
  resource_group_name = "${azurerm_resource_group.svcplan.name}"

  frontend_ip_configuration {
    name                 = "${azurerm_public_ip.appsvc.name}"
    public_ip_address_id = "${azurerm_public_ip.appsvc.id}"
  }
}