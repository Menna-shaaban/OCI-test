#load Balancer for high availability and automated traffic destribtion


resource "oci_load_balancer_load_balancer" "LB" {
  compartment_id = var.compartment_ocid
  display_name = "load_balancer"
  subnet_ids = [oci_core_subnet.public_subnet1.id]

  shape ="flexible"

  shape_details {
      minimum_bandwidth_in_mbps = var.load_balancer_min_band
      maximum_bandwidth_in_mbps = var.load_balancer_max_band
       
    
  }
  network_security_group_ids = [oci_core_network_security_group.LBSecurityGroup.id]

}

#load balancer BE set
resource "oci_load_balancer_backend_set" "web_back_set" {
    health_checker {
        protocol="HTTP"
        port = "80"
        interval_ms = "10000"
        response_body_regex = ""
        retries ="3"
        return_code = "200"
        timeout_in_millis = "3000"
        url_path = "/"
    }
    load_balancer_id =  oci_load_balancer_load_balancer.LB.id  
    name = "Load_Balancer_Backend_Set"
    policy ="ROUND_ROBIN"             #round robin simple, best for web servers with same capacity
    #other policies:use request's IP address as a hashing key to route non-sticky traffic to the same backend server)
    #& Least Connections:helps you maintain an equal distribution of active connections with backend servers

  
}
#load balancer BE listener
resource "oci_load_balancer_listener" "listener" {
    load_balancer_id         =  oci_load_balancer_load_balancer.LB.id 
    name                     = "http"
    default_backend_set_name =  oci_load_balancer_backend_set.web_back_set.name 
    port                     = 80
    protocol                 = "HTTP"
}

resource "oci_load_balancer_backend" "lb-web1" {
    load_balancer_id = oci_load_balancer_load_balancer.LB.id 
    backendset_name  =  oci_load_balancer_backend_set.web_back_set.name 
    ip_address       =  oci_core_instance.web_01.private_ip 
    port             = "80"
    backup           = false
    drain            = false
    offline          = false
}
resource "oci_load_balancer_backend" "lb-web2" {
    load_balancer_id =  oci_load_balancer_load_balancer.LB.id 
    backendset_name  =  oci_load_balancer_backend_set.LB_set.name  
    ip_address       =  oci_core_instance.web_02.private_ip 
    port             = "80"
    backup           = false
    drain            = false
    offline          = false
}




