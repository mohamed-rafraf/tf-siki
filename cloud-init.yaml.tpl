#cloud-config
users:
  - name: ubuntu
    ssh_authorized_keys:
      - ${ssh_public_key}  # Inject the public key dynamically
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    groups: sudo
    shell: /bin/bash

packages:
  - openssh-server
  - python3
  - python3-pip
  - ansible

runcmd:
  - apt-get update -y
  - apt-get upgrade -y
  - systemctl enable ssh
  - systemctl restart ssh

# Network configuration for static IP
network:
  version: 2
  ethernets:
    enp0s8:
      dhcp4: false
      addresses:
        - ${static_ip}/24
      gateway4: ${gateway}
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
