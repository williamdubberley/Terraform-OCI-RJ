output "RJ_URL" {
  description = "url to connect to"
  value       = module.rj.RJ_URL
}

output "ADW_URL" {
  description = "url to connect to"
  value       = var.adw_enabled ? module.adw.ADW_URL : null
}

output "OAC_URL" {
  description = "url to connect to"
  value       = var.oac_enabled ? module.oac.OAC_URL : null
}

