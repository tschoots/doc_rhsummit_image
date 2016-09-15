#!/bin/bash

VBoxManage startvm summit2016 --type headless

ssh -p 2222 -o ServerAliveInterval=10 root@localhost
