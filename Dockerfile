from    ubuntu:16.04

# Config apt
run     sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/gi' /etc/apt/sources.list
run     apt-get update && apt-get -y upgrade

# Install required packages
run     apt-get update && apt-get -y install libffi-dev libcairo2-dev wget python-dev
run     wget -c https://bootstrap.pypa.io/get-pip.py
run     python get-pip.py
add     pip.conf ~/.pip/pip.conf
run     pip install scandir==1.5  gunicorn==19.7.1 zope.interface==4.4.0
run     pip install whisper==1.0.1
run     pip install graphite-web==1.0.1 --install-option="--prefix=/opt/graphite" --install-option="--install-lib=/opt/graphite/webapp"
run     pip install carbon==1.0.1 --install-option="--prefix=/opt/graphite" --install-option="--install-lib=/opt/graphite/lib"
add     ./local_settings.py /opt/graphite/webapp/graphite/local_settings.py
add     ./storage-schemas.conf /opt/graphite/conf/storage-schemas.conf
run     cp /opt/graphite/conf/carbon.conf.example /opt/graphite/conf/carbon.conf
run     mkdir -p /opt/graphite/storage/whisper
run     touch /opt/graphite/storage/graphite.db /opt/graphite/storage/index
run     mkdir -p /opt/graphite/storage/log/webapp
run     cd /opt/graphite/webapp && PYTHONPATH=. python /opt/graphite/bin/django-admin.py migrate --settings=graphite.settings --run-syncdb
run     chown -R www-data /opt/graphite/storage
run     chmod 0775 /opt/graphite/storage /opt/graphite/storage/whisper
run     chmod 0664 /opt/graphite/storage/graphite.db

# Grafana
run     apt-get update && apt-get -y install curl apt-transport-https
run     curl -s https://packagecloud.io/gpg.key | apt-key add -
run     echo "deb https://packagecloud.io/grafana/stable/debian/ jessie main" | tee -a /etc/apt/sources.list
run     apt-get update && apt-get -y install grafana
arg     GRAFANA_USERNAME=grafana
arg     GRAFANA_PASSWORD=grafana
arg     GRAFANA_URL=http://localhost:3000
run     sed -i "s/;admin_user = admin/admin_user = $GRAFANA_USERNAME/gi" /etc/grafana/grafana.ini
run     sed -i "s/;admin_password = admin/admin_password = $GRAFANA_PASSWORD/gi" /etc/grafana/grafana.ini
run     sed -i "s/;allow_sign_up = true/allow_sign_up = false/gi" /etc/grafana/grafana.ini
run     sed -i "s~;root_url = http://localhost:3000~root_url = $GRAFANA_URL~gi" /etc/grafana/grafana.ini

# Install nginx
# add   ./nginx.conf /etc/nginx/nginx.conf

# Supervisor
run     apt-get update && apt-get -y install supervisor
add     ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Carbon
expose  2003
expose  2003/udp
expose  2004
expose  7002
# Grafana
expose  3000
# Graphite-Web
expose  8081

add     ./entry_point.sh /usr/bin/entry_point.sh
cmd     ["bash", "/usr/bin/entry_point.sh"]

# vim:ts=8:noet:
