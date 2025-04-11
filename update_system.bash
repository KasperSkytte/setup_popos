#!/usr/bin/env bash
#Update system (first run only)
set -eux
sudo apt-get update -y
sudo apt-get upgrade -y --allow-downgrades
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autoclean -y
