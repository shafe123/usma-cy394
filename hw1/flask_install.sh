sudo apt install python-is-python3 python3-pip -y
cd usma-cy394/hw1
pip3 install flask
python -m flask --app flaskr init-db
python -m flask --app flaskr run --host 0.0.0.0
cd ~
