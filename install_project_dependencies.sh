#!/bin/bash 

deactivate

sudo systemctl start gunicorn.socket

sudo systemctl enable gunicorn.socket

sudo ln -s /etc/nginx/sites-available/textutils  /etc/nginx/sites-enabled/

sudo rm /etc/nginx/sites-enabled/default

sudo systemctl restart nginx
sudo systemctl restart gunicorn
