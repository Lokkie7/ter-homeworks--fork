resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_web_family}"
}


resource "yandex_compute_instance" "platform" {
  count       = 2
  name        = "web-${count.index+1}"

  platform_id = "${var.vm_web_platform}"
  resources {
    cores         = "${var.vms_resourses_web.cores}"
    memory        = "${var.vms_resourses_web.memory}"
    core_fraction = "${var.vms_resourses_web.core_fraction}"
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = "${var.vm_web_ispreemptible}"
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.develop.id}"
    nat       = "${var.vm_web_nethasnat}"
    security_group_ids = [ yandex_vpc_security_group.example.id ]
  }

  metadata = {
    serial-port-enable = "${var.metadata.serial-port-enable}"
    ssh-keys           = "ubuntu:${var.metadata.ssh-keys}"
  }
}
