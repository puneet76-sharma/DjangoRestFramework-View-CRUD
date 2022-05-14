#!/bin/bash
rm -rf /home/ubuntu/*
cd /home/ubuntu
sudo apt update
sudo apt install python3-pip python3-dev nginx -y
pip install virtualenv
virtualenv myprojectenv
source myprojectenv/bin/activate
pip install django gunicorn
