terraform {
  required_version = ">= 0.13"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.84.0"
    }
  }

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "tf-sf-anton"
    region     = "ru-central1"
    key        = "tf_remote.tfstate"
    //access_key = <PASTE YOUR ACCESS KEY HERE>
    //secret_key = <PASTE YOUR SECRET KEY HERE>
    access_key = "YCAJEs-TeN6Nzvg0uGVSGNVOi"
    secret_key = "YCOdlE1eRmV_e5BTFgFcygEauMiMNBqHC8c4HkD5"

    skip_region_validation      = true
    skip_credentials_validation = true
  }

}

provider "yandex" {
  service_account_key_file = "./key.json"
  //zone                     = "ru-central1-a"
  folder_id                = "b1ghmnbhv26t427tkagk"
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

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.11.0/24"]
}

module "ya-vm-1"  {
  source          = "./modules/ya-vm"
  image_name      = "lamp"
  image_family    = "lamp"
  source_image_id = "fd8ce6so660hmgehordb"
  instance_name   = "yc-in-01"
  host_name       = "yc-in-01"
  cpu_core        = 2
  mem_size        = 2
  core_fraction   = 20
  disk_size       = 10
  vpc_subnet_id   = yandex_vpc_subnet.subnet-1.id
  zone_name       = "ru-central1-a"
}

module "ya-vm-2" {
  source          = "./modules/ya-vm"
  image_name      = "lemp"
  image_family    = "lemp"
  source_image_id = "fd8movi7o1ofl59h1uu9"
  instance_name   = "yc-in-02"
  host_name       = "yc-in-02"
  cpu_core        = 2
  mem_size        = 2
  core_fraction   = 20
  disk_size       = 10
  vpc_subnet_id   = yandex_vpc_subnet.subnet-2.id
  zone_name       = "ru-central1-b"
}