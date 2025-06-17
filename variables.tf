variable "vsphere_server" {
  description = "The vCenter server FQDN or IP address."
  type        = string
}

variable "vsphere_user" {
  description = "The username for vCenter server."
  type        = string
}

variable "vsphere_password" {
  description = "The password for vCenter server."
  type        = string
  sensitive   = true
}

variable "vsphere_allow_unverified_ssl" {
  description = "Allow insecure SSL connections to vCenter server."
  type        = bool
  default     = false
}

variable "vsphere_datacenter_name" {
  description = "The name of the vSphere Datacenter."
  type        = string
}

variable "vsphere_datastore_name" {
  description = "The name of the vSphere Datastore."
  type        = string
}

variable "vsphere_compute_cluster_name" {
  description = "The name of the vSphere Compute Cluster."
  type        = string
}

variable "vsphere_resource_pool_name" {
  description = "The name or path of the vSphere Resource Pool."
  type        = string
}

variable "vsphere_host_name" {
  description = "The name of the vSphere ESXi Host."
  type        = string
}

variable "vsphere_network_name" {
  description = "The name of the vSphere Network (Port Group)."
  type        = string
}
