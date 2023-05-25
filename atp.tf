resource "oci_database_autonomous_database" "ATP" {
    compartment_id         = var.compartment_id
    autonomous_database_id = oci_database_autonomous_database.ATP.id
    admin_password         = var.db_pass
    db_name                = var.db_name
    display_name           = "ATP DB"
    cpu_core_count         ="1"
    data_storage_size_in_tbs ="1"
    is_free_tier           = true
    subnet_id              = oci_core_subnet.private_subnet.id
    is_data_guard_enabled  =false
    nsg_ids                =[oci_core_network_security_group.DB_NSG.id]
    private_endpoint_label =var.private_endpoint ? var.private_endpoint_label:null
  
}
#wallet for credintials
#create randome passphrase for each login
resource "random_string" "wallet_password" {
  length  = 8
  special = true
}


resource "oci_database_autonomous_database_wallet" "ATP_wallet" {
    autonomous_database_id = oci_database_autonomous_database.ATP.id
    password = random_string.wallet_password.result

}