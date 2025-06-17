terraform {

}

locals {
  hostname     = lower(var.hostname)
  ipv4_address = "${data.vsphere_network.network.subnet}.${var.ipv4_host}"
  gateway      = "${data.vsphere_network.network.subnet}1"
}

data "template_cloudinit_config" "user_data" {
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/templates/userdata.yaml.tftpl", {
      username = var.linux_username

      hostname     = local.hostname
      ipv4_address = local.ipv4_address
      gateway      = local.gateway

      ssh_key = file("${path.module}/keys/id_ed25519.pub")

      path_module = path.module
    })
  }
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.hostname
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  folder           = var.vm_folder != "" ? var.vm_folder : null

  num_cpus = var.vm_cores
  memory   = var.vm_memory
  guest_id = var.guest_os_id

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = var.network_adapter_type
  }

  disk {
    label       = "disk0"
    size        = var.vm_disk_size
    unit_number = 0
  }

  ovf_deploy {
    allow_unverified_ssl_cert = false
    local_ovf_path            = "/opt/ISO/ubuntu-server-cloudimg-amd64.ova"
    disk_provisioning         = "thin"
    ip_protocol               = "IPV4"
    ip_allocation_policy      = "STATIC_MANUAL"
    ovf_network_map = {
      "Network 1" = data.vsphere_network.network.id
    }
  }

  vapp {
    properties = {
      "user-data" = "${data.template_cloudinit_config.user_data.rendered}"
    }
  }

  lifecycle {
    ignore_changes = [
      vapp[0].properties,
      ovf_deploy[0].local_ovf_path,
      //ovf_deploy[0].remote_ovf_url,
      disk[0].size,
      num_cpus,
      memory,
      resource_pool_id,
      datastore_id,
    ]
  }
}
