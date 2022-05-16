#!/usr/bin/env bash
set -eu
ansible_venv=${ansible_venv:-"ansible-venv"}

message() {
    echo "*** $1"
}

install_pkgs() {
    message "Checking for required system packages..."
    pkgs="software-properties-common python3-venv"
    if ! dpkg -s $pkgs >/dev/null 2>&1
    then
        message "One or more system packages are not installed, installing..."
        sudo apt-get update -qqy
        sudo apt-get install -y $pkgs
    else
        message "All required system packages are already installed..."
    fi
}

setup_ansible() {
    message "Installing ansible into virtual environment: ${ansible_venv}..."
    python3 -m venv "$ansible_venv"
    . "${ansible_venv}/bin/activate"
    python3 -m pip install ansible
    #ansible-galaxy collection install community.general --roles roles
    message "Installing ansible-galaxy roles..."
    ansible-galaxy install -r roles/requirements.yml --roles roles/
}

install_pkgs
setup_ansible
