variable "each_vm" {
  type = map(object({
    vm_name=string,
    platform_db_id=string,
    cpu=number,
    ram=number,
    fraction=number,
    ispreem=bool,
    nat_db=bool,
    serial=number,
    ssh=string }))
  default = {
    db1 = {
      vm_name = "main"
      platform_db_id = "standard-v3"
      cpu = 2
      ram = 2
      fraction = 20
      ispreem = true
      nat_db = true
      serial = 1
      ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjfVGkByr8vEZZMnNiPAjbVjbfQyLOGBqwsv7GNgZF7 Liza0@Lokkie7"
      },
    db2 = {
      vm_name = "replica"
      platform_db_id = "standard-v3"
      cpu = 2
      ram = 2
      fraction = 20
      ispreem = true
      nat_db = true
      serial = 1
      ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjfVGkByr8vEZZMnNiPAjbVjbfQyLOGBqwsv7GNgZF7 Liza0@Lokkie7"
    }
  }
}

resource "yandex_compute_instance" "platform2" {
  for_each      = var.each_vm
  name        = each.value.vm_name
  platform_id = each.value.platform_db_id
  zone        = "ru-central1-a"
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = each.value.ispreem
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.develop.id}"
    nat       = each.value.nat_db
  }

  metadata = {
    serial-port-enable = each.value.serial
    ssh-keys           = each.value.ssh
  }

}
