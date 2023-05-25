# provider "oci" {
#     user_ocid    = var.user_ocid
#     tenancy_ocid = var.tenancy_ocid
#     region       = var.region
#     fingerprint  = var.fingerprint
# }

# Network resources
resource "oci_core_vcn" "VCN" {
    cidr_block     = var.vcn_cidr
    compartment_id = var.compartment_ocid
    display_name   = var.vcn_dns_label  
    dns_label      = var.vcn_dns_label  
}
resource "oci_core_subnet" "public_subnet1" {
    cidr_block           = cidrsubnet(var.vcn_cidr,8,1)
    display_name         = "SubnetA"
    dns_label            = "subnet1"
    compartment_id       = var.compartment_ocid
    vcn_id               = oci_core_vcn.VCN.id 
    route_table_id       = oci_core_route_table.RT.id 
    
}
resource "oci_core_subnet" "public_subnet2" {
    cidr_block          = cidrsubnet(var.vcn_cidr,8,2)
    display_name        = "SubnetB"
    dns_label           = "subnet2"
    compartment_id      = var.compartment_ocid
    vcn_id              = oci_core_vcn.VCN.id
    route_table_id      = oci_core_route_table.RT.id
  
}

resource "oci_core_subnet" "private_subnet" {
    cidr_block          = cidrsubnet(var.vcn_cidr,8,3)
    display_name        = "PrivateSubnet"
    dns_label           = "privat-subnet"
    compartment_id      = var.compartment_ocid
    vcn_id              = oci_core_vcn.VCN.id
    route_table_id      = oci_core_route_table.Pri_RT.id
  
}
resource "oci_core_internet_gateway" "internet_gateway" {
    compartment_id = var.compartment_ocid
    display_name   = "IG"
    vcn_id         = oci_core_vcn.VCN.id
  
}

resource "oci_core_nat_gateway" "nat_gw" {
    compartment_id = var.compartment_ocid
    display_name   = "Nat_gateway"
    vcn_id         = oci_core_vcn.VCN.id
}

resource "oci_core_route_table" "RT" {
    compartment_id = var.compartment_ocid
    vcn_id =  oci_core_vcn.VCN.id 
    display_name = "public Route Table"
    route_rules {
        destination = "0.0.0.0/0"
        destination_type="CIDR_BLOCK"
        network_entity_id =  oci_core_internet_gateway.internet_gateway.id 
        }
  
}
resource "oci_core_route_table" "Pri_RT" {
    compartment_id = var.compartment_ocid
    vcn_id =  oci_core_vcn.VCN.id 
    display_name = "Private Route Table"
    route_rules {
        destination = "0.0.0.0/0"
        destination_type="CIDR_BLOCK"
        network_entity_id =  oci_core_nat_gateway.nat_gw.id 
        }
  
}
