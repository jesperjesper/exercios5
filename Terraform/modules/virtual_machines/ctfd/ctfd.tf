terraform {
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.51.1"
    }
  }
}

provider "openstack" {
  user_name            = "group_20_ikt114"
  password             = "258f81b3c1a44b6ab817171d106c2f07"
  auth_url             = "http://kaun.uia.no:5000/v3"
  project_domain_name  = "IT_ORKESTRERING"
  user_domain_name     = "IT_ORKESTRERING"
}

resource "openstack_compute_instance_v2" "ctfd" {
  name            = "ctfd-vm"
  image_name      = "centos_image"
  flavor_name     = "medium-server"
  key_pair        = "my-keypair"
  security_groups = ["default"]

  user_data = file("/home/jespereh/exercise05/Terraform/cloud-init.cfg")

  network {
    name = "Group_20_network"
  }
}


resource "openstack_networking_floatingip_v2" "ctfd_floating_ip" {
  pool = "provider"
}

resource "openstack_compute_floatingip_associate_v2" "ctfd_floating_ip_association" {
  floating_ip = openstack_networking_floatingip_v2.ctfd_floating_ip.address
  instance_id = openstack_compute_instance_v2.ctfd.id
}
