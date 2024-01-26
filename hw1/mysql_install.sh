sudo apt update -y
sudo apt upgrade -y
sudo apt install mysql-server
sudo sed -i -e 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo systemctl restart mysql
password=$(sudo cat /etc/mysql/debian.cnf | grep password | tail -n 1 | awk '{print $3}')
mysql -u debian-sys-maint -p"${password}"
