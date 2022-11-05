
# Elemets of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html

###########  Web Servers   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "bootstorage" {
  count        = 1
  name         = "bootstorage${count.index + 1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      # image list can be found at:
      # https://cloud.google.com/compute/docs/images
      image = "ubuntu-2004-focal-v20221015"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../id_rsa.pub")}"
  }
  tags = ["bootstorage"]
}

resource "google_compute_instance" "expressed" {
  count        = 1
  name         = "expressed${count.index + 1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      # image list can be found at:
      # https://cloud.google.com/compute/docs/images
      image = "ubuntu-2004-focal-v20221015"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../id_rsa.pub")}"
  }
  tags = ["expressed"]
}

resource "google_compute_instance" "happy" {
  count        = 1
  name         = "happy${count.index + 1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      # image list can be found at:
      # https://cloud.google.com/compute/docs/images
      image = "ubuntu-2004-focal-v20221015"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../id_rsa.pub")}"
  }
  tags = ["happy"]
}

resource "google_compute_instance" "vuecalc" {
  count        = 2
  name         = "vuecalc${count.index + 1}"
  machine_type = var.GCP_MACHINE_TYPE
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      # image list can be found at:
      # https://cloud.google.com/compute/docs/images
      image = "ubuntu-2004-focal-v20221015"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../id_rsa.pub")}"
  }
  tags = ["vuecalc"]
}

resource "google_compute_instance" "monitoring" {
  count        = 1
  name         = "monitor"
  machine_type = var.GCP_MACHINE_TYPE
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      # image list can be found at:
      # https://cloud.google.com/compute/docs/images
      image = "ubuntu-2004-focal-v20221015"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../id_rsa.pub")}"
  }
  tags = ["monitoring"]
}

###########  Load Balancer   #############
resource "google_compute_instance" "balancer" {
  name         = "balancer"
  machine_type = var.GCP_MACHINE_TYPE
  zone         = var.GCP_ZONE

  boot_disk {
    initialize_params {
      # image list can be found at:
      # https://cloud.google.com/compute/docs/images
      image = "ubuntu-2004-focal-v20221015"
    }
  }

  network_interface {
    network = "default"
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("../id_rsa.pub")}"
  }

  tags = ["balancer"]
}


###########  Output to Ansible   #############

resource "local_file" "hosts_cfg" {
  content = templatefile("./templates/hosts.tftpl",
    {
      loadbal_IPs     = google_compute_instance.balancer.*.network_interface.0.access_config.0.nat_ip
      bootstorage_IPs = google_compute_instance.bootstorage[*].network_interface.0.access_config.0.nat_ip
      expressed_IPs   = google_compute_instance.expressed[*].network_interface.0.access_config.0.nat_ip
      happy_IPs       = google_compute_instance.happy[*].network_interface.0.access_config.0.nat_ip
      vuecalc_IPs     = google_compute_instance.vuecalc[*].network_interface.0.access_config.0.nat_ip
      monitoring_IPs  = google_compute_instance.monitoring[*].network_interface.0.access_config.0.nat_ip
    }
  )
  filename = "gcphosts"
}

resource "local_file" "env_file" {
  content = templatefile("./templates/env.tftpl",
    {
      expressed_IPs = google_compute_instance.expressed[*].network_interface.0.access_config.0.nat_ip
      happy_IPs     = google_compute_instance.happy[*].network_interface.0.access_config.0.nat_ip
    }
  )
  filename = "../vuecalc/.env"
}
