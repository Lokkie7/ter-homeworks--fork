variable "disk_size" {
  type        = number
  default     = 1
}

variable "disk_bsize" {
  type        = number
  default     = 4096
}

resource "yandex_compute_disk" "empty-disk" {
  count       = 3
  name        = "empty-disk-${count.index+1}"
  type       = "network-hdd"
  zone       = var.default_zone
  size       = var.disk_size
  block_size = var.disk_bsize
}

resource "yandex_compute_instance" "platform3" {
  name        = "storage"
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
  
dynamic "secondary_disk" {
    for_each = yandex_compute_disk.empty-disk
    content {
      disk_id = lookup(secondary_disk.value, "id", null)
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

