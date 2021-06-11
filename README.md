# ubuntu-dev-machine-setup | Ubuntu 20.04 LTS

This repo contains Ansible playbooks to configure your system as a development machine upon a clean install.

The playbooks should run in Debian based system but was only tested with:
- **Ubuntu 20.04**
- **Ubuntu Budgie 20.04**
- **Ubuntu 20.10**
- **Ubuntu Budgie 20.10**
- **Ubuntu 21.04**

For other versions of Ubuntu, change to the other branches of this git repo.

![bullet-train-zsh-theme](.images/screenshot-bullet-train.png)

Screenshot above is using *bullet-train zsh theme*

![pure-zsh-theme](.images/screenshot-pure.png)

Screenshot above is using *pure zsh theme*

![p10k-zsh-theme-tmux](.images/screenshot-p10k-tmux.png)

Screenshot above is using *p10k zsh theme with tmux*


## Pre-requisites

On the system which you are going to setup using Ansible, perform these steps.

You need to install `ansible` and `git` before running the playbooks. You can either install it using `pip` or `apt`.

```
/usr/bin/sudo apt install ansible git
```

And clone this repo

```
git clone https://github.com/fazlearefin/ubuntu-dev-machine-setup.git
cd ubuntu-dev-machine-setup
```

## Running the playbooks to configure your system

**Invoke the following as yourself, the primary user of the system. Do not run as `root`.**

```
ansible-playbook main.yml -e "{ laptop_mode: True }" -e "local_username=$(id -un)" -K
```

Enter the sudo password when asked for `BECOME password:`.

The `main.yml` playbook will take anything from 15 minutes to an hour to complete.

After all is done, give your laptop a new life by rebooting.

> ### What is this `laptop_mode`?

#### Setting this to `True`

- will install some packages like [TLP](https://github.com/linrunner/TLP) for battery economy
- will not install and configure ssh server

#### Setting this to `False`

- will not install some packages like `powertop` for battery economy
- will install and configure ssh server

## What gets installed and cofigured?

I am a DevSecOps Engineer (focusing on Linux) and my daily job include working with various config management using Ansible. So if you are in a similar profession the installed system will suit your needs. It is also easy to extend using Ansible roles.

Summary of packages that get installed and configured based on roles:

- **role: base**
  - mount `/tmp` on tmpfs (reduce SSD read writes and increase SSD lifespan; no leftover files on system shutdown)
  - set default system editor to vi instead of nano
  - enable ufw firewall but open ssh port with rate limiting
  - disable system crash reports
  - tune system swappiness so that swapping is greatly reduced
  - upgrade all packages
  - install archiving tools like zip, rar, etc
  - install libreoffice
  - install power management tools like [TLP](https://github.com/linrunner/TLP)
  - install system customization tools like gnome-tweak-tool
  - install development related packages like android-tools, awscli, httpie, clusterssh, docker, filezilla, golang, pipenv, etc
  - install golang directories
  - install download tools like axel, transmission, wget, aria2
  - install image, audio and video packages like vlc, totem, gimp, imagemagick, etc
  - install virtualization tools like virtualbox, docker, docker-compose
  - install and configure ssh server if not set to `laptop_mode`
- **role: hashicorp**
  - install vagrant, terraform, packer
- **role: terminal_customizations**
  - download and install some nerd fonts from ryanoasis/nerd-fonts; these are mono fonts ideal for use in terminal or programming editors
  - copy and enable sample tilix config file with configured nerd font
  - copy and enable sample tmux config file if one does not exist
  - copy and enable sample `~/.tmux.conf` file with powerline status bar and mouse support!
    - open Tilix terminal and run `tmux` command, or enable custom command option in Tilix
    - edit `~/.tmux.conf` if necessary
- **role: vim**
  - install vim packages
  - install amix/vimrc vim distribution
  - create sample vim customization file in `~/.vim_runtime/my_configs.vim`
    - additional vim settings are enabled in `~/.vim_runtime/my_configs.vim` which are not part of the Vim Distribution. Edit this file if necessary.
- **role: zsh**
  - install zsh package and set user shell to zsh
  - install antigen zsh plugin manager
  - copy and enable sample `~/.zshrc` file if one does not exist
    - contains function to stop ssh-agent from asking for encrypted ssh key password repeatedly when launching new terminal
  - install ohmyzsh/ohmyzsh and enable some bundled plugins
  - enable bullet train zsh theme (others like p10k can be configured as well)
- **role: googlechrome**
  - add Google Chrome apt repo
  - install Google Chrome
- **role: vscode**
  - add Visual Studio Code apt repo
  - install Visual Studio Code
  - install some popular Visual Studio Code extensions
- **role: privacy**
  - install tor
  - configure tor to run at boot and prevent using certain countries as exit nodes
    - edit `/etc/tor/torrc` if necessary
  - install proxychains
  - configure proxychains to use tor. Visit [my blog post](https://fazlearefin.blogspot.com/2020/07/tunneling-traffic-over-tor-network.html) to see how to use it
    - edit `/etc/proxychains4.conf` if necessary
  - install metadata anonymization toolkit
- **role: security**
  - install ClamAV (antivirus) and ClamAV GNOME interface. Manual scan from nautilus or from CLI using `clamscan`; real-time scanning not enabled for performance reasons

## Known Issues

- If the ansible playbook halts after completing a few tasks, simply run the playbook again. Since most of the tasks are idempotent, running the playbook multiple times won't break anything.
- If your terminal shows any weird characters because of installing one of the zsh themes, simply change the font to a suitable Nerd Font from the terminal's settings.

## Pull Requests and Forks

You are more than welcome to send any pull requests. However, the intention of this repo is to suit my development needs. So it might be better if you *fork* this repo instead for your own needs and personalization.

## Donations

Bitcoin (BTC): `38uvDLV4GzcAB7qMUEM5chqivESqNPWPZW`

Ethereum (ETH): `0xb87A10e8e3fa4Ea71b478f8f0c8798977dBe28Ed`

Litecoin (LTC):`MRAwH2WHUprCn5RcpKWKMkfaUJicTpsbWr` or `3Jxny96KXhzmya9iiSWyY7RB9c8AXRGN3n`
