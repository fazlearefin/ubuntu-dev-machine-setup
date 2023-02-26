#!/bin/bash

ansible-galaxy install gantsign.minikube

ansible-galaxy install -r requirements.yaml

ansible-playbook main.yml -vv -e "{ laptop_mode: True }" -e "local_username=$(id -un)" -K
