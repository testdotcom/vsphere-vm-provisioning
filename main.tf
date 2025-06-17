terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.12.0"
    }
  }
}

provider "vsphere" {
  vsphere_server       = var.vsphere_server
  user                 = var.vsphere_user
  password             = var.vsphere_password
  allow_unverified_ssl = var.vsphere_allow_unverified_ssl
}

data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter_name
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_compute_cluster_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "default" {
  name          = var.vsphere_resource_pool_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "host" {
  name          = var.vsphere_host_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}
