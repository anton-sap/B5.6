terraform {
  required_version = ">= 0.13"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
    }
  }
}

data "yandex_compute_image" "my-image" {
  //name         = var.image_name
  family       = var.image_family
  //source_image = var.source_image_id
}

resource "yandex_compute_instance" "yc-instance" {
  name     = var.instance_name
  hostname = var.host_name
  zone     = var.zone_name

  resources {
    cores         = var.cpu_core
    memory        = var.mem_size
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my-image.id
      size     = var.disk_size
    }
  }

    network_interface {
    subnet_id = var.vpc_subnet_id
    nat       = true
  }

  metadata = {
    user-data = "${file("./metadata.yaml")}"
  }
}