sudo apt update -y
sudo apt upgrade -y
sudo apt install apache2 -y
sudo a2enmod proxy_http lbmethod_bytraffic
read -p "Enter the flask IP address: " flaskip
echo "<VirtualHost *:80>
    ServerName cy394.com

    <Proxy balancer://flaskbalancer/>
        BalancerMember http://$flaskip:5000/
        ProxySet lbmethod=bytraffic
    </Proxy>

    ProxyPass "/"  "balancer://flaskbalancer/"
    ProxyPassReverse "/"  "balancer://flaskbalancer/"
</VirtualHost>

<Location "/balancer-manager">
    SetHandler balancer-manager
    Require host localhost
</Location>" | sudo tee -a /etc/apache2/sites-available/flask.conf
sudo ln -s /etc/apache2/sites-available/flask.conf /etc/apache2/sites-enabled/flask.conf
sudo rm /etc/apache2/sites-enabled/000-default.conf
sudo systemctl restart apache2
