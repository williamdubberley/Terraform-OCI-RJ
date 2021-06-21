/* 
Git hub Repository for OCI modules used to build RJ Stack, includes ADB Systems, DBAS, OAC, Relational Junction, and VCN
 */
module "source" {
  source = "git::github.com/williamdubberley/Terrafom-Modules-OCI.git"
}
/*
Local Variables
 */
locals {
  public_subnet_id  = var.rj_vcn_use_existing ? var.rj_subnet_public_existing : module.vcn.public-subnetid
  private_subnet_id = var.rj_vcn_use_existing ? var.rj_subnet_private_existing : module.vcn.private-subnetid
  ssh_public_key    = file("${var.ssh_public_key_path}")
  private_key       = file("${var.ssh_private_key_path}")

}
/* Virtual Cloud Network  */
module "vcn" {
  source                        = "./.terraform/modules/source/networking"
  compartment_ocid              = var.compartment_ocid
  rj_subnet_public_displayname  = var.rj_subnet_public_displayname
  rj_subnet_public_cidr         = var.rj_subnet_public_cidr
  rj_subnet_private_displayname = var.rj_subnet_private_displayname
  rj_subnet_private_cidr        = var.rj_subnet_private_cidr
  rj_vcn_use_existing           = false
  rj_pub_subnet_dns_label       = var.rj_pub_subnet_dns_label
  rj_pvt_subnet_dns_label       = var.rj_pvt_subnet_dns_label
  rj_IGW_displayname            = var.rj_IGW_displayname
  rj_vcn_cider_block            = var.rj_vcn_cider_block
  rj_pvt_sl_displayname         = var.rj_pvt_sl_displayname
  rj_pub_sl_displayname         = var.rj_pub_sl_displayname
  rj_pvt_rt_displayname         = var.rj_pvt_rt_displayname
  rj_pub_rt_displayname         = var.rj_pub_rt_displayname
  rj_vcn_dns_label              = var.rj_vcn_dns_label
  rj_VCN_displayname            = var.rj_VCN_displayname
  rj_nat_displayname            = var.rj_nat_displayname
}

/* 
Autonomous Data Wearhouse
*/
module "adw" {
  source                                       = "./.terraform/modules/source/Databases/ADW"
  autonomous_database_admin_password           = var.autonomous_database_admin_password
  compartment_ocid                             = var.compartment_ocid
  autonomous_database_cpu_core_count           = var.autonomous_database_cpu_core_count
  autonomous_database_data_storage_size_in_tbs = var.autonomous_database_data_storage_size_in_tbs
  autonomous_database_db_name                  = var.autonomous_database_db_name
  autonomous_database_db_version               = var.autonomous_database_db_version
  autonomous_database_data_safe_status         = var.autonomous_database_data_safe_status
  autonomous_database_db_workload              = var.autonomous_database_db_workload
  autonomous_database_display_name             = var.autonomous_database_display_name
  autonomous_database_is_auto_scaling_enabled  = var.autonomous_database_is_auto_scaling_enabled
  autonomous_database_license_model            = var.autonomous_database_license_model
  adw_enabled                                  = var.adw_enabled
  walletPath                                   = "${path.module}/${var.autonomous_database_db_name}.zip"
}

/*
Relational Junction 
*/
module "rj" {
  source           = "./.terraform/modules/source/relationalJunction"
  compartment_ocid = var.compartment_ocid
  depends_on       = [module.vcn, module.adw]
  rj_shape         = var.rj_shape
  rj_instance_name = var.rj_instance_name
  tags             = var.tags
  subnet_id        = local.public_subnet_id
  ssh_public_key   = local.ssh_public_key
  ssh_private_key  = local.private_key
  walletPath       = "${path.module}/"
  walletName       = "${var.autonomous_database_db_name}.zip"
  dbname           = var.autonomous_database_db_name
  region           = var.region
  tenancy_ocid     = var.tenancy_ocid
}

/*
Oracle Analytics Cloud
 */
module "oac" {
  source             = "./.terraform/modules/source/oac"
  oac_enabled        = var.oac_enabled
  oac_capacity_type  = var.oac_capacity_type
  oac_capacity_value = var.oac_capacity_value
  compartment_ocid   = var.compartment_ocid
  oac_feature_set    = var.oac_feature_set
  oac_license_type   = var.oac_license_type
  oac_idcs_token     = var.oac_idcs_token
  oac_name           = var.oac_name
  oac_description    = var.oac_description
}
