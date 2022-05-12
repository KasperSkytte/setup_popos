#!/usr/bin/env bash
set -eu
ansible_venv=${ansible_venv:-"ansible-venv"}

install_pkgs() {
    echo "Checking for required system packages..."
    pkgs="software-properties-common pipenv"
    if ! dpkg -s $pkgs >/dev/null 2>&1
    then
        echo "One or more system packages are not installed, installing..."
        sudo apt-get update -qqy
        sudo apt-get install -y $pkgs
    else
        echo "All required system packages are already installed..."
    fi
}

setup_ansible() {
    #ansible-galaxy collection install community.general --roles roles
    echo "Installing ansible-galaxy roles into ./roles..."
    pipenv run ansible-galaxy install -r roles/requirements.yml --roles roles
}

install_pkgs
setup_ansible

echo
echo "Done setting up. To run the playbook run the following in the root of this repository:"
echo "  pipenv shell"
echo  "  ansible-playbook playbook.yml --ask-become-pass"
