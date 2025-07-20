# Setup Pop!_OS after a clean install
Setup a clean machine as I'm used to it. No personal settings or secrets here.

## Installation
 - **Inspect everything here first**. Don't just trust a random guy on the internet straight away.
 - Clone this repository on the machine where [**Pop!_OS**](https://pop.system76.com/) has just been installed
 - Make adjustments to the playbook and roles if needed, and variables in `vars/main.yml`.
 - Run `bash run_playbook.bash playbook.yml` to run install Ansible into a virtual environment and from there run the [playbook.yml](playbook.yml).

## TODO
 - Adjust default APT repo from a set variable
 - Replace run command in `/user/share/applications/gitkraken.desktop` for GitKraken to support github key from 1password:
    `Exec=env SSH_AUTH_SOCK=~/.1password/agent.sock /usr/share/gitkraken/gitkraken %U`
 - Install yubikey authenticator
 - Install jumpcloud agent
 - Disable mouse acceleration
 - Setup personal dotfiles
 - Setup yubikey for sudo (and remove password-less sudo in general role) (https://dev.to/bashbunni/set-up-yubikey-for-passwordless-sudo-authentication-4h5o)
   ```
   mkdir ~/.config/Yubico
   pamu2fcfg > ~/.config/Yubico/u2f_keys #interactive, must type code and touch yubikey
   # in /etc/pam.d/sudo add "auth sufficient pam_u2f.so" before "common-auth" line
   ```
 - setup hostname
