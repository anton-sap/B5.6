variable "image_name" {
  type        = string
  description = "Image Name"
}

variable "image_family" {
  type        = string
  description = "Yandex Image Family" //Can be found on https://cloud.yandex.com/en/marketplace/products/yc/lamp
}

variable "source_image_id" {
  type         = string
  description = "Yandex Image ID" // Can be found on https://cloud.yandex.com/en/marketplace/products/yc/lamp
}

variable "instance_name" {
  type        = string
  description = "Instance Name"
}

variable "host_name" {
  type        = string
  description = "Host Name"
}

variable "zone_name" {
  type        = string
  description = "Zone Name"
}

variable "cpu_core" {
  type        = number
  default     = 2
  description = "CPU Count"
}

variable "mem_size" {
  type        = number
  default     = 2
  description = "Memory Size"
}

variable "core_fraction" {
  type        = number
  default     = 20 // Available option is 20, 50 and 100
  description = "CPU Fraction"
}

variable "disk_size" {
  type        = number
  default     = 10
  description = "Disk Size"
}

variable "vpc_subnet_id" {
  type        = string
  description = "VPN Network Subnet ID"
}