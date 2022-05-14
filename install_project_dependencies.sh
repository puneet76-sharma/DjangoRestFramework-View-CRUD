#!/bin/bash 

deactivate

echo "[Unit]
Description=gunicorn socket
[Socket]
ListenStream=/run/gunicorn.sock
[Install]
WantedBy=sockets.target
" > /etc/systemd/system/gunicorn.socket

echo " [Unit]
Description=gunicorn daemon
Requires=gunicorn.socket
After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/project
ExecStart=/home/ubuntu/venv/bin/gunicorn \
          --access-logfile - \
          --workers 3 \
          --bind unix:/run/gunicorn.sock \
          ViewDemo_Project.wsgi:application
[Install]
WantedBy=multi-user.target"  >  /etc/systemd/system/gunicorn.service

sudo systemctl start gunicorn.socket

sudo systemctl enable gunicorn.socket


echo "server {
    listen 80;
    server_name puneet.co.vu;
    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/ubuntu/project;
    }
    location / {
        include proxy_params;
        proxy_pass http://unix:/run/gunicorn.sock;
    }
}" > /etc/nginx/sites-available/ViewDemo_Project


sudo ln -s /etc/nginx/sites-available/ViewDemo_Project  /etc/nginx/sites-enabled/

sudo rm /etc/nginx/sites-enabled/default


sudo systemctl restart nginx
sudo systemctl restart gunicorn
