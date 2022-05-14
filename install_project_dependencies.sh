#!/bin/bash 

cd /home/ubuntu

source venv/bin/activate

cd /home/ubuntu/project
pip install -r requirements.txt

sudo fuser -k 8000/tcp

gunicorn --bind 0.0.0.0:8000 first.wsgi &>/dev/null & 

# mv /home/ubuntu/gunicorn.socket /etc/systemd/system/
# mv /home/ubuntu/gunicorn.service /etc/systemd/system/

# sudo systemctl start gunicorn.socket
# sudo systemctl enable gunicorn.socket

mv /home/ubuntu/NGINX /etc/nginx/sites-available 

sudo ln -s /etc/nginx/sites-available/NGINX /etc/nginx/sites-enabled/

sudo rm /etc/nginx//sites-enabled/default

sudo systemctl restart nginx
sudo systemctl restart gunicorn
