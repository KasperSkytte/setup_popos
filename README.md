# Setup Pop!_OS after a clean install
Setup a clean machine as I'm used to it. No personal settings or secrets here.

Currently, this playbook will install:
 - [ ] nvidia drivers with matching version of CUDA
 - [ ] nvidia docker support (`nvidia.nvidia_docker` role needs adjustment to work with Pop!_OS atm)
 - [x] zsh (set as default shell instead of bash)
 - [ ] dotfiles (personal)
 - [x] Teleport
 - [x] Tailscale
 - [x] Brave
 - [x] Spotify
 - [ ] Slack
 - [ ] Teams
 - [x] GitKraken
 - [x] Nextcloud sync client (with desktop autostart)
 - [x] Docker
 - [x] R
 - [ ] RStudio
 - [x] VSCode
   - [x] Install nautilus "open folder in vscode" extension
 - [x] etckeeper
 - [x] sshfs

Plus some other utilities like `nmap`, `net-tools` etc.

# Installation
 - **Inspect everything here first**. Don't just trust a random guy on the internet straight away.
 - Clone this repository on the machine where [**Pop!_OS**](https://pop.system76.com/) has just been installed
 - Run the [update_system.bash](update_system.bash) script to update the system in general through APT
 - Make adjustments to the playbook and roles if you want
 - Run `bash run_playbook.bash playbook.yml` to run install Ansible into a virtual environment and from there run the [playbook.yml](playbook.yml).

# To-do
 - Adjust default APT repo from a set variable
 - Replace run command in `/user/share/applications/gitkraken.desktop` for GitKraken to support github key from 1password:
    `Exec=env SSH_AUTH_SOCK=~/.1password/agent.sock /usr/share/gitkraken/gitkraken %U`
 - Install yubikey authenticator
 - Install jumpcloud agent