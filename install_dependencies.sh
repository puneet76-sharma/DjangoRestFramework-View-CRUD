#!/bin/bash

cd /home/ubuntu
sudo apt update
sudo apt install python3-pip python3-dev nginx -y
pip install virtualenv
virtualenv venv
source venv/bin/activate
pip install django gunicorn
pip install -r requirements.txt
