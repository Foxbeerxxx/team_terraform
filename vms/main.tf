locals {
  ssh_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}

data "template_file" "cloud_init" {
  template = file("${path.module}/cloud-init.yml")
  vars = {
    ssh_key = local.ssh_key
  }
}

resource "yandex_compute_instance" "vm_marketing" {
  name        = "vm-marketing"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"  

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data = data.template_file.cloud_init.rendered
  }

  labels = {
    project = "marketing"
  }
}

resource "yandex_compute_instance" "vm_analytics" {
  name        = "vm-analytics"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    user-data = data.template_file.cloud_init.rendered
  }

  labels = {
    project = "analytics"
  }
}
