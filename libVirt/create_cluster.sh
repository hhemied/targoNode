#!/bin/bash

asible-playbook build_vm.yaml
if [ $? == 0 ]; then
    ansible bastion -a 'hostnamectl'
