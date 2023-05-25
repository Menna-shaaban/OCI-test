#for_flask
sudo yum install -y nginx && sudo -u yum install -y python36
pip install --upgrade Flask
pip install cx_Oracle
#web_server
sudo systemctl enable --now nginx.service
sudo systemctl status nginx
#adding firewall
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-port=80/tcp
sudo firewall-cmd --reload
echo "hello in our web app"