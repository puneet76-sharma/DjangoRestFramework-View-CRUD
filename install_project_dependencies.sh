#!/bin/bash 

cd /home/ubuntu/project
pip3 install -r requirements.txt

deactivate

echo " [Unit] 
Description=gunicorn socket
[Socket]
ListenStream=/run/gunicorn.sock
[Install]
WantedBy=sockets.target" > /etc/systemd/system/gunicorn.socket

echo " [Unit]
Description=gunicorn daemon
Requires=gunicorn.socket
After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu
ExecStart=/home/ubuntu/env/bin/gunicorn \
          --access-logfile - \
          --workers 3 \
          --bind unix:/run/gunicorn.sock \
          assigndjnago.wsgi:application
[Install]
WantedBy=multi-user.target" >  /etc/systemd/system/gunicorn.service

sudo systemctl start gunicorn.socket
sudo systemctl enable gunicorn.socket


sudo ln -s /etc/nginx/sites-available/textutils /etc/nginx/sites-enabled/
sudo rm /etc/nginx//sites-enabled/default

sudo systemctl restart nginx
sudo systemctl restart gunicorn
