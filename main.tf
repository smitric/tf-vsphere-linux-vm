# =================== #
# Deploying VMware VM #
# =================== #

# Connect to VMware vSphere vCenter
terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere-user
  password             = var.vsphere-password
  vsphere_server       = var.vsphere-vcenter
  allow_unverified_ssl = var.vsphere-unverified-ssl
  vim_keep_alive = 30
}

# Define VMware vSphere 
data "vsphere_datacenter" "dc" {
  name = var.vsphere-datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.vm-datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere-cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vm-network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = "${var.vsphere-template-folder}/${var.vm-template-name}"
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Create VMs
resource "vsphere_virtual_machine" "vm" {
  count = var.vm-count

  name             = "${var.vm-name}-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = var.vm-cpu
  memory   = var.vm-ram
  guest_id = var.vm-guest-id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "${var.vm-name}-${count.index + 1}-disk"
    thin_provisioned = true
    eagerly_scrub = false
    size  = 50
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = "${var.vm-name}-${count.index + 1}"
        domain    = var.vm-domain
      }     
      network_interface {
        ipv4_address = "${lookup(var.vm_ips, count.index)}"
        ipv4_netmask = "${var.vm_netmask}"
      }
      timeout = 30
      
      ipv4_gateway    = "${var.vm_gateway}"
      dns_server_list = ["${var.vm_dns}"]
    }
  }
}
