# ubuntu-desktop-setup

This repo contains Ansible playbooks to configure your system as a development machine upon a clean install. The playbooks should run in Debian based system but was only tested with **Ubuntu 17.04**

## Pre-requisites

You need to install Ansible before running the playbooks. You can either install it using `pip` or though `apt`.

```
sudo apt install ansible
```

## Running the playbooks to configure your system

Invoke the following as yourself, the primary use. Not `root`. Change the value of `local_username` with your own username.

```
ansible-playbook site.yml -e "{ laptop_mode: True }" -e "local_username=$(logname)" -K
```

### What is this `laptop_mode`?

#### Setting this to `True`

- will install some packages like `powertop` for battery economy
- will not install and configure ssh server

#### Setting this to `False`

- will not install some packages like `powertop` for battery economy
- will install and configure ssh server
