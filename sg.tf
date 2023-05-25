resource "oci_core_network_security_group" "LBSecurityGroup" {
    compartment_id = var.compartment_ocid
    display_name   = "LBSecurityGroup"
    vcn_id         =  oci_core_vcn.VCN.id 
}
# Rules related to LBSecurityGroup
# EGRESS
resource "oci_core_network_security_group_security_rule" "LB_EgressRule" {
    network_security_group_id =  oci_core_network_security_group.LBSecurityGroup.id
    direction                 = "EGRESS"
    protocol                  = "6"
    destination               = "0.0.0.0/0"
    destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "LB_ingressRule" {
    network_security_group_id =  oci_core_network_security_group.LBSecurityGroup.id
    direction                 = "INGRESS"
    protocol                  = "6"
    source                    = "0.0.0.0/0"
    source_type               = "CIDR_BLOCK"
    tcp_options {
        destination_port_range {
        max = 80
        min = 80
        }
    }
}


resource "oci_core_network_security_group" "websr_NSG" {
    compartment_id = var.compartment_ocid
    display_name   = "WebSecurityGroup"
    vcn_id         =  oci_core_vcn.VCN.id 
}
resource "oci_core_network_security_group_security_rule" "websr_Interet_egress_rule" {

    network_security_group_id =  oci_core_network_security_group.websr_NSG.id 
    direction = "EGRESS"
    protocol = "6" #TCP
    destination=oci_core_subnet.public_subnet1.cidr_block
    destination_type = "CIDR_BLOCK"
}
resource "oci_core_network_security_group_security_rule" "websr_DB_egress_rule" {

    network_security_group_id =  oci_core_network_security_group.websr_NSG.id 
    direction = "EGRESS"
    protocol = "6" #TCP
    destination= oci_core_network_security_group.DB_NSG.id
    destination_type = "NETWORK_SECURITY_GROUP"
}
resource "oci_core_network_security_group_security_rule" "websr_NSG_ingress_rule" {

    network_security_group_id =  oci_core_network_security_group.websr_NSG.id 
    direction = "INGRESS"
    protocol = "6" #TCP
    source=oci_core_subnet.public_subnet1.cidr_block
    source_type = "CIDR_BLOCK"
    tcp_options{
        destination_port_range {
            max = 80
            min = 80
        }
    }
}
#DB_SG
resource "oci_core_network_security_group" "DB_NSG" {
    compartment_id = var.compartment_ocid
    display_name   = "DB_NSG"
    vcn_id         =  oci_core_vcn.VCN.id 
}
resource "oci_core_network_security_group_security_rule" "DB_NSG_egress_rule" {

    network_security_group_id =  oci_core_network_security_group.DB_NSG.id 
    direction = "EGRESS"
    protocol = "6" #TCP
    destination=oci_core_subnet.public_subnet2.cidr_block
    destination_type = "CIDR_BLOCK"
}

resource "oci_core_network_security_group_security_rule" "DB_NSG_ingress_rule" {

    network_security_group_id =  oci_core_network_security_group.DB_NSG.id 
    direction = "INGRESS"
    protocol = "6" #TCP
    source=oci_core_subnet.public_subnet2.cidr_block
    source_type = "CIDR_BLOCK"
    tcp_options{
        destination_port_range {
            max = 1522
            min = 1522
        }
    }
}

resource "oci_core_network_security_group" "SSH_SG" {
  compartment_id = var.compartment_ocid
  display_name   = "SSH_SG"
  vcn_id         = oci_core_vcn.VCN.id
}

# Rules related to SSHSecurityGroup
# EGRESS
resource "oci_core_network_security_group_security_rule" "SSH_SG_EgressRule" {
  network_security_group_id = oci_core_network_security_group.SSH_SG.id
  direction                 = "EGRESS"
  protocol                  = "6"
  destination               = "0.0.0.0/0"
  destination_type          = "CIDR_BLOCK"
}
# INGRESS
resource "oci_core_network_security_group_security_rule" "SSH_SG_IngressRule" {
  network_security_group_id = oci_core_network_security_group.SSH_SG.id
  direction                 = "INGRESS"
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  tcp_options {
    destination_port_range {
      max = 22
      min = 22
    }
  }
}