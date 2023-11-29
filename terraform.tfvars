# ======================== #
# VMware VMs configuration #
# ======================== #

vm-count = 1
vm-name = "ubuntu22"
vm-template-name = "tpl-ubuntu-2204"
vm-cpu = 2
vm-ram = 4096
vm-guest-id = "ubuntu64Guest"

# ============================ #
# VMware vSphere configuration #
# ============================ #

# VMware vCenter IP/FQDN
vsphere-vcenter = "10.0.201.2"

# VMware vSphere username used to deploy the infrastructure
vsphere-user = "administrator@vsphere.local"

# VMware vSphere password used to deploy the infrastructure
vsphere-password = "A5kedz2h!"

# Skip the verification of the vCenter SSL certificate (true/false)
vsphere-unverified-ssl = "true"

# vSphere datacenter name where the infrastructure will be deployed
vsphere-datacenter = "Datacenter"

# vSphere cluster name where the infrastructure will be deployed
vsphere-cluster = "redhat"

# vSphere Datastore used to deploy VMs 
vm-datastore = "VM-Backup"

# vSphere Network used to deploy VMs 
vm-network = "Lab VM"

# VM IPs
vm_ips = {
   "0" = "10.0.201.150"
   "1" = "10.0.200.251"
#  "2" = "10.0.200.248"
}

# Default gateway for VMs
vm_gateway = "10.0.201.1"

# DNS IP address
vm_dns = "10.0.201.1"

# Linux virtual machine domain name
vm-domain = "local"

vm_netmask = 24