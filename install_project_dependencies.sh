#!/bin/bash 

deactivate

mv /home/ubuntu/gunicorn.socket /etc/systemd/system/

mv /home/ubuntu/gunicorn.service /etc/systemd/system/

sudo systemctl start gunicorn.socket

sudo systemctl enable gunicorn.socket


mv /home/ubuntu/configruation /etc/nginx/sites-available/


sudo ln -s /etc/nginx/sites-available/configruation /etc/nginx/sites-enabled/

sudo rm /etc/nginx/sites-enabled/default


sudo systemctl restart nginx
sudo systemctl restart gunicorn
