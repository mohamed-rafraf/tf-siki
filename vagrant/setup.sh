#!/bin/bash

update_system() {
    echo "Updading and Upgrading the system .."
    sudo apt update -y 
    sudo apt upgrade -y
}

install_python() {
    echo "Installing Python and Pip ..."
    sudo apt install -y python3 python3-pip
    python3 --version 
    pip3 --version
}


enable_ssh() {
    echo "Enabling SSH service..."
    sudo systemctl enable ssh
    sudo systemctl start ssh
    sudo systemctl status ssh
}

install_ansible() {
    # Install Ansible
    echo "Installing Ansible..."
    sudo apt install -y ansible
    ansible --version
}


main() {
    update_system
    install_python
    enable_ssh
    install_ansible
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
	set -euxo pipefail

	main "$@"
	echo "all done!"
fi