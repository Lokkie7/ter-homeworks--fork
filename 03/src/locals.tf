locals {
  tags = {
    one = "${yandex_compute_disk.empty-disk[0].id}",
    two = "${yandex_compute_disk.empty-disk[1].id}",
    three = "${yandex_compute_disk.empty-disk[2].id}"
    }
}

