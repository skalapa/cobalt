output "appgateway_name" {
  description = "The name of the Application Gateway created"
  value       = "${azurerm_application_gateway.appgateway.name}"
}

output "appgateway_ipconfig" {
  description = "The Application Gateway IP Configuration"
  value = "${azurerm_application_gateway.appgateway.gateway_ip_configuration}"
}

output "appgateway_frontend_ip_configuration" {
  description = "The Application Gateway Frontend IP Configuration"
  value = "${azurerm_application_gateway.appgateway.frontend_ip_configuration}"
}
