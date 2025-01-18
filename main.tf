terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

provider "virtualbox" {
  # Configuration options
}
resource "virtualbox_vm" "ubuntu_vm" {
  name         = "ubuntu-ansible"
  cpus         = 2
  memory       = "2048 mib"
  network_adapter {
    type           = "hostonly"
    host_interface = "vboxnet0"
  }

  # Download the Ubuntu ISO (replace with your path or ensure the ISO is available)
  image = "/home/mohamed/Downloads/jammy-server-cloudimg-amd64-vagrant.box"
  user_data = data.template_file.cloud_init.rendered


}

locals {
  ssh_public_key = file("/home/mohamed/.ssh/id_rsa.pub")
}

data "template_file" "cloud_init" {
  template = file("${path.module}/cloud-init.yaml.tpl")
  vars = {
    ssh_public_key = local.ssh_public_key
    static_ip      = var.static_ip
    gateway        = var.gateway
  }
}