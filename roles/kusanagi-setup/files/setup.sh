#!/bin/bash
# based on https://github.com/ConoHa/startupscripts/blob/master/scripts/setup_kusanagi.sh

export LANG=C

# yum update -y

mkp="mkpasswd -l 10 -s 0"

password=`$mkp`
passphrase=`$mkp`
dbpassword=`$mkp`

echo "SET PASSWORD = PASSWORD('$dbpassword')" | mysql -uroot

cat <<EOF > /root/.my.cnf
[mysqladmin]
password = "$dbpassword"
user = root
EOF
chmod 600 /root/.my.cnf

cat <<EOF > /etc/kusanagi.conf
PROFILE=""
EOF

kusanagi init \
    --tz tokyo \
    --lang ja \
    --keyboard ja \
    --passwd $password \
    --phrase $passphrase \
    --dbrootpass $dbpassword \
    --nginx \
    --php7 \
    --ruby24 \
    --dbsystem mariadb

cat << EOF >> /etc/motd
================================================
kusanagi user password  : $password
kusanagi user passphrase: $passphrase
MySQL root password     : $dbpassword

To delete this message: rm -f /etc/motd
================================================
EOF
