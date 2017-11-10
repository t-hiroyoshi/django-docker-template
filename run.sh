#/bin/sh

python3 manage.py migrate
python3 manage.py loaddata initial_data
python3 manage.py collectstatic --noinput
supervisord -n
