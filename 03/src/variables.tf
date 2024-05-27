###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "..."
  description = "ssh-keygen -t ed25519"
}

#my variables

variable "vm_web_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "image family"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v3"
  description = "choosing a processor"
}

variable "vms_resourses_web" {
  description = "Tags to set for resources"
  type        = map(number)
  default         = {
    cores       = 2
    memory      = 1
    core_fraction = 20
  }
}
variable "vms_resourses_db" {
  description = "Tags to set for resources"
  type        = map(number)
  default         = {
    cores       = 2
    memory      = 2
    core_fraction = 20
  }
}


variable "metadata" {
  description = "Tags to set for resources"
  type        = map
  default         = {
    serial-port-enable = 1
    ssh-keys           = "..."
  }
}

variable "vm_web_ispreemptible" {
  type        = bool
  default     = true
  description = "is vm preemptible"
}

variable "vm_web_nethasnat" {
  type        = bool
  default     = true
  description = "nat for net"
}

variable "vm_web_role" {
  type        = string
  default     = "web"
}

