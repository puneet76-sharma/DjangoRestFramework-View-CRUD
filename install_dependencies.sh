#!/bin/bash

cd /home/ubuntu
sudo apt update
sudo apt install python3-pip python3-dev nginx -y
pip3 install virtualenv
virtualenv venv
source venv/bin/activate
pip3 install django gunicorn
pip3 install -r requirements.txt
