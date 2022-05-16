#!/usr/bin/env bash
set -eu
ansible_venv=${ansible_venv:-"ansible-venv"}
export playbook_file=${playbook_file:-"playbook.yml"}

# shellcheck source=/dev/null
. "${ansible_venv}/bin/activate"
ansible-playbook "${playbook_file}" "$@"
deactivate
