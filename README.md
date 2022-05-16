# Setup Pop!_OS after a clean install
Setup a clean machine as I'm used to it. No personal settings or secrets here.

Currently, this playbook will install:
 - [x] zsh (set as default shell instead of bash)
 - [ ] dotfiles (personal)
 - [x] Teleport
 - [x] Tailscale
 - [x] Brave
 - [x] Spotify
 - [x] Slack
 - [x] Teams
 - [x] GitKraken
 - [x] Nextcloud sync client (with desktop autostart)
 - [x] Docker
 - [x] R
 - [ ] RStudio
 - [x] VSCode
   - [ ] Install nautilus "open folder in vscode" extension from https://github.com/KasperSkytte/code-nautilus
 - [x] openvpn (no configs)
 - [x] etckeeper
 - [x] sshfs
 - [z] filezilla

# Installation
 - **Inspect everything here first**. Don't just trust a random guy on the internet straight away.
 - Clone this repository on the machine where [**Pop!_OS**](https://pop.system76.com/) has just been installed
 - Run the [first_run.bash](first_run.bash) script to update the system in general through APT
 - Make adjustments to the playbook and roles if you want
 - Run the [setup_ansible.bash](setup_ansible.bash) script to install ansible into a virtual environment in the current folder as well as required ansible galaxy roles
 - Run [run_playbook.bash](run_playbook.bash) to run activate the virtual environment and run the [playbook.yml](playbook.yml).
