 resource "oci_database_db_system" "dev_db_system" {
     #Required
     availability_domain = var.availability_domain
     compartment_id = var.compartment_nonprod_ocid
     db_home {
         #Required
         database {
             #Required
             admin_password = var.database_admin_password
             db_name = "DEVDB"  
             db_workload = var.database_db_workload
             pdb_name = var.database_pdb_name	
            
         }

         #Optional
         db_version = var.database_version
         display_name = join("_",[var.Resource_suffix_dev, var.Resource_main,"DB"])  #Dev_Analytics_DB
     }
     hostname = join("",[var.Resource_suffix_dev, var.Resource_main,"DB"])  #Dev_Analytics_DB 
	 shape = var.database_shape
     ssh_public_keys = [var.database_ssh_pub_key]
     subnet_id = oci_core_subnet.subnet_dev_private.id	
	 data_storage_size_in_gb = var.database_storage
	 database_edition = var.database_edition
	 display_name=join("_",[var.Resource_suffix_dev, var.Resource_main,"DB"])	
	 domain = local.Private_Subnet_Dns			# domain should be same as subnet
	 node_count = var.database_nodecount
 } 