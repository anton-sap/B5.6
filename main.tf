terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  service_account_key_file = "./key.json"
  zone                     = "ru-central1-a"
  folder_id                = "b1ghmnbhv26t427tkagk"
}

resource "yandex_compute_image" "lemp" {
  name         = "my-lemp-image"
  family       = "lemp"
  source_image = "fd8c9koat6nv4qacg49b"
}

resource "yandex_compute_instance" "lemp-node-01" {
  name     = "lemp-node-01"
  hostname = "lemp-node-01"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = "${yandex_compute_image.lemp.id}"
      size     = 15
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./metadata.yaml")}"
  }
}


resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

output "internal_ip_address_vm_1" {
  value = yandex_compute_instance.lemp-node-01.network_interface.0.ip_address
}


output "external_ip_address_vm_1" {
  value = yandex_compute_instance.lemp-node-01.network_interface.0.nat_ip_address
}

