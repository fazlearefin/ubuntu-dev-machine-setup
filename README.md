# ubuntu-dev-machine-setup

This repo contains Ansible playbooks to configure your system as a development machine upon a clean install. The playbooks should run in Debian based system but was only tested with **Ubuntu 18.04**

## Pre-requisites

On the system which you are going to setup using Ansible, perform these steps.

You need to install Ansible and git before running the playbooks. You can either install it using `pip` or though `apt`.

```
sudo apt install ansible git
```

And clone this repo

```
git clone https://github.com/fazlearefin/ubuntu-dev-machine-setup.git
cd ubuntu-dev-machine-setup
```

## Running the playbooks to configure your system

Invoke the following as yourself, the primary use. Not `root`.

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

## What gets installed and cofigured?

I am a Linux Systems Engineer and my daily job include working with various config management using Ansible. So if you are in a similar profession the installed system will suit your needs. It is also easy to extend using Ansible roles.

Summary of packages that get installed and configured:

- Archiving tools like zip, rar, etc
- Customization tools like gnome-tweak-tool, etc
- Power management tools like cpufrequtils, powertop, etc
- Download utils like aria2, wget, axel, etc
- Developer tools like awscli, httpie, parallel-ssh, clusterssh, vagrant, virtualbox, etc
- Google Chrome
- Atom Editor and Atom packages
- Git Bash Prompt
- ssh server
- zsh shell, antigen plugin manager, oh-my-zsh plugins
- Powerline Fonts
- Reduce swappiness for better perfomance
- Mount `/tmp` on tmpfs
- Enable ufw firewall and configure for incoming ssh

## Known Issues

Installation of Atom Editor might fail on first run of the Ansible playbook. In case you get Atom Editor installation error, simply run the playbook again. Most of the tasks are idempotent, so running the playbook multiple times is safe.

## Pull Requests and Forks

You are more than welcome to send any pull requests. However, the interntion of this repo is to suit my development needs. So it might be better if you *fork* this repo instead for your own needs and personalization.
