# Variables

#*************************************
#           TF Requirements
#*************************************
variable "tenancy_ocid" {
  default = ""
}
variable "region" {
  default = ""
}
variable "user_ocid" {
  default = ""
}
variable "ssh_public_key_path" {
  default = ""
}
variable "ssh_private_key_path" {
  default = ""
}
variable "private_key_path" {
  default = " "
}
variable "fingerprint" {
  default = ""
}
variable "compartment_ocid" {
  default = ""
}

#*************************************
#           ADW VARABLES
#*************************************

variable "adw_enabled" {
  description = "whether to create ADW server"
  default     = false
  type        = bool
}

variable "autonomous_database_cpu_core_count" {
  default = "1"
}

variable "autonomous_database_admin_password" {
}

variable "autonomous_database_db_name" {
  default = "ADWDB"
}

variable "autonomous_database_display_name" {
  default = "My ADW DB"
}

variable "autonomous_database_db_version" {
  default = "19c"
}

variable "autonomous_database_is_auto_scaling_enabled" {
  default = "false"
}

variable "autonomous_database_data_storage_size_in_tbs" {
  default = "1"
}

variable "autonomous_database_db_workload" {
  default = "DW"
}

variable "autonomous_database_license_model" {
  default = "BRING_YOUR_OWN_LICENSE"
}

variable "autonomous_database_data_safe_status" {
  default = "NOT_REGISTERED"
}

#*************************************
#           VCN VARABLES
#*************************************


variable "rj_subnet_public_displayname" {
  default = "Relational Junction - Public"
}
variable "rj_subnet_public_cidr" {
  default = "10.0.0.0/24"
}
variable "rj_subnet_private_displayname" {
  default = "Relational Junction - Private"
}
variable "rj_subnet_private_cidr" {
  default = "10.0.1.0/24"
}
variable "rj_vcn_use_existing" {
  default = false
}
variable "rj_vcn_existing" {
  default = ""
}
variable "rj_subnet_public_existing" {
  default = ""
}
variable "rj_subnet_private_existing" {
  default = ""
}
variable "rj_pub_subnet_dns_label" {
  default = "rjpublic"
}
variable "rj_pvt_subnet_dns_label" {
  default = "rjprivate"
}
variable "rj_IGW_displayname" {
  default = "Relational Junction IGW"
}
variable "rj_vcn_cider_block" {
  default = "10.0.0.0/16"
}
variable "rj_pvt_sl_displayname" {
  default = "Relational Junction - Private SL"
}
variable "rj_pub_sl_displayname" {
  default = "Relational Junction - Public SL"
}
variable "rj_pvt_rt_displayname" {
  default = "Relational Junction - Private RT"
}
variable "rj_pub_rt_displayname" {
  default = "Relational Junction - Public RT"
}
variable "rj_vcn_dns_label" {
  default = "rjvcn"
}
variable "rj_VCN_displayname" {
  default = "Relational Junction VCN"
}
variable "rj_nat_displayname" {
  default = "Relational Junction NAT"
}




#*************************************
#        Local Variables
#*************************************

variable "rj_enabled" {
  description = "whether to create RJ server"
  default     = true
  type        = bool
}
variable "rj_instance_name" {
  description = "instance name and dns hostname of the RJ server"
  default     = "rjserver"
  type        = string
}
variable "rj_shape" {
  description = "Compute Shape"
  default     = "VM.Standard2.4"
  type        = string
}
variable "rj_type" {
  description = "Compute Shape"
  default     = "Relational Junction Standard"
  type        = string
}

variable "timeout" {
  description = "Timeout setting for resource creation "
  default     = "20m"
}
variable "compute_instance_user" {
  description = "Login user for application instance"
  default     = "opc"
}

variable "ad_number" {
  default     = 1
  description = "Which availability domain to deploy to depending on quota, zero based."
}


variable "tags" {
  description = "simple key-value pairs to tag the resources created"
  type        = map(any)
  default = {
    environment = "poc"
  }
}

#*************************************
#           Data Sources
#*************************************

data "oci_identity_tenancy" "tenant_details" {
  #Required
  tenancy_id = var.tenancy_ocid
}
data "oci_identity_regions" "home-region" {
  filter {
    name   = "key"
    values = [data.oci_identity_tenancy.tenant_details.home_region_key]
  }
}
data "oci_identity_regions" "current_region" {
  filter {
    name   = "name"
    values = [var.region]
  }
}
data "oci_identity_compartment" "current_compartment" {
  #Required
  id = var.compartment_ocid
}

variable "ad_name" {
  default = ""
}
variable "subnet_id" {
  default = ""
}
variable "walletPath" {
  default = ""
}



## Database

variable "database_admin_password" {
  type        = string
  description = "provide value of Database Password"
}

variable "database_db_unique_name" {
  type        = string
  description = "provide value of Database Unique Name"
}

variable "database_db_workload" {
  type        = string
  description = "provide value of Database workload"
}

variable "database_pdb_name" {
  type        = string
  description = "provide value of Database PDB Name"
}

variable "database_version" {
  type        = string
  description = "provide value of Database Version"
}

variable "database_shape" {
  type        = string
  description = "provide value of Database Shape"
}

variable "database_shape_prod" {
  type        = string
  description = "provide value of Database Shape for Production DB"
}

variable "database_storage" {
  type        = string
  description = "provide value of Database Storage"
}

variable "database_storage_prod" {
  type        = string
  description = "provide value of Database Storage for Production DB"
}

variable "database_edition" {
  type        = string
  description = "provide value of Database Edition"
}

variable "database_ssh_pub_key" {
  type        = string
  description = "provide value of Database Public SSH Key"
}

variable "database_nodecount" {
  type        = string
  description = "provide value of Database Node Count"
}

## OAC
variable "oac_enabled" {
  description = "whether to create Analytics Server"
  default = true
  type    = bool
}

variable "oac_name" {
  type        = string
  description = "provide value of OAC Name"
}
variable "oac_description" {
  type        = string
  description = "provide value of OAC Description"
}
variable "oac_capacity_type" {
  type        = string
  description = "provide value of OAC Capacity Type"
}

variable "oac_capacity_value" {
  type        = string
  description = "provide value of OAC Capacity Value"
}

variable "oac_capacity_value_prod" {
  type        = string
  description = "provide value of OAC Capacity Value for Production"
}

variable "oac_feature_set" {
  type        = string
  description = "provide value of OAC Feature set"
}

variable "oac_license_type" {
  type        = string
  description = "provide value of OAC Licence Type"
}

variable "oac_idcs_token" {
  type        = string
  description = "provide value of OAC IDCS Token"
}
