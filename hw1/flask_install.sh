sudo apt install python-is-python3 python3-pip python3-flask -y
cd usma-cy394/hw1
pip3 install flask
flask --app flaskr init-db
flask --app flaskr run --host 0.0.0.0
cd ~