variable "tenancy_ocid" {}
variable "compartment_ocid" {}
variable "ssh_public_key" {}

variable "availability_domain" {
    # AD:1 FD:2
    default = "1" 
}
variable "region"{
    default="eu-amsterdam-1"
}
variable "vcn_cidr" {
    default= "10.0.0.0/16"
}

variable "vcn_dns_label" {
    description= "VCN DNS label"
    default = "vcn1"
}
variable "dns_label" {
    description= "Subnet DNS label"
    default = "subnet"
}

variable "os_image" {
  default     = "Oracle Linux"
}

variable "image_os_version" {
  default     = "8"

}
variable "instance_shape" {
    description = "Instance Shape"
    default = "VM.Standard.E2.1.Micro"  #free tiers shape
}
variable "load_balancer_min_band" {
    description = "Load Balancer Min Band"
    default = "10"
  
}
variable "load_balancer_max_band" {
    description = "Load Balancer Max Band"
    default = "10"  
}
# variable "NumInstances" {
#     default = "1"
# }

variable "db_name" {
    default = "ADMIN"
  
}
variable "db_pass" {
    default = "Atp_db1"
  
}
variable "db_version"{
    default = "19c"
}
variable "private_endpoint"{
    default = true
}
variable "private_endpoint_label"{
    default = "ATP_private_end_point"
}
