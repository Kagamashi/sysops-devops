
## Installation
# Linux/macOS Installation (via pip)
pip install ansible

# Debian-based (Ubuntu/Debian)
sudo apt update && sudo apt install ansible -y


## Docker
# run ansible inside container
docker run --rm -it ansible/ansible bash
# mounts current directory into the container allowing to execute playbooks
docker run --rm -it -v $(pwd):/workspace ansible/ansible bash


## Ansible CLI
ansible --version
ansible-galaxy collection list  # checks installed collections

ansible           # runs ad-hoc commands on remote systems

ansible-playbook  # executes playbooks (YAML-based automation scripts)
  ansible-playbook site.yaml
  ansible-playbook -i inventory.ini site.yaml --limit webservers # run for specific group
  ansible-playbook -i inventory.ini site.yaml --check # test without making changes

ansible-config    # manages Ansible configuration (ansible.cfg)
  ansible-config dump   # check current configuration

ansible-doc       # display documentation for ansible modules

ansible all -m ping # run ping on all hosts
ansible all -m command -a "uptime" # execute command on remote host
ansible all --list-hosts # lists all hosts
ansible all -m setup     # list all facts