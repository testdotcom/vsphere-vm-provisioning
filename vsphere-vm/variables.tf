variable "hostname" {
  description = "Hostname for the VM."
  type        = string
}

variable "vm_cores" {
  description = "Number of virtual CPUs for the VM."
  type        = number
}

variable "vm_memory" {
  description = "Amount of memory (MB) for the VM."
  type        = number
}

variable "vm_disk_size" {
  description = "Storage size (GB) of the VM's primary disk."
  type        = number
}

variable "ipv4_host" {
  description = "IPv4 host number, e.g., '42', for the VM's primary network interface."
  type        = string
}

variable "linux_username" {
  description = "Username for the Linux machine."
  type        = string
  default     = "ubuntu"
}

variable "guest_os_id" {
  description = "Guest OS ID for the VM, e.g., 'ubuntu64Guest'."
  type        = string
}

variable "vm_folder" {
  description = "Target folder in vCenter for the VM. Leave empty for the datacenter root."
  type        = string
  default     = ""
}

variable "network_adapter_type" {
  description = "Network adapter type, e.g., vmxnet3 or e1000e."
  type        = string
  default     = "vmxnet3"
}
