
data "template_file" "user_data" {
  template = file("server.sh")
}
resource "oci_core_instance" "web_01" {
  availability_domain = data.oci_identity_availability_domains.AD.availability_domains[var.availability_domain -1]["name"]
  compartment_id = var.compartment_ocid
  display_name = "Web_ser01"
  fault_domain = "FAULT-DOMAIN-1"

  shape = var.instance_shape


  create_vnic_details {
    subnet_id = "${oci_core_subnet.public_subnet2.id}"
    display_name = "primaryvnic"
    assign_public_ip = true
  }
 
  source_details {
    source_type = "image"
    source_id = lookup(data.oci_core_images.compute_images.images[0],"id")
    boot_volume_size_in_gbs = "50"
  }
  metadata={
        ssh_authorized_keys = chomp(file(var.ssh_public_key))

        user_data =base64encode(data.template_file.user_data.rendered) 


 }
  
  
}


resource "oci_core_instance" "web_02" {
  availability_domain = data.oci_identity_availability_domains.AD.availability_domains[var.availability_domain -1]["name"]
  compartment_id = var.compartment_ocid
  display_name = "Web_ser02"
  fault_domain = "FAULT-DOMAIN-2"

  shape = var.instance_shape
  create_vnic_details {
    subnet_id = "${oci_core_subnet.public_subnet2.id}"
    display_name = "standbyvnic"
    assign_public_ip = true
      }
 
  source_details {
    source_type = "image"
    source_id = lookup(data.oci_core_images.compute_images.images[0], "id")
    boot_volume_size_in_gbs = "50"
  }
  metadata={
        ssh_authorized_keys = chomp(file(var.ssh_public_key))

        user_data =base64encode(data.template_file.user_data.rendered) 
      }
}

