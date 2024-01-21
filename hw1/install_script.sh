cd usma-cy394/hw1
apt install python-is-python3 python3-pip python3-flask -y
pip3 install flask
flask --app flaskr init-db
flask --app flaskr --host 0.0.0.0 run