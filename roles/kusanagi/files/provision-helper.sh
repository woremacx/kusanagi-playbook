#!/bin/bash

NAME=$(mkpasswd -l 6 -s 0 -C 0)
DB=db$NAME
DBUSER=u$NAME
DBPASS=$(mkpasswd -l 10 -s 0)

# echo $DB $DBUSER $DBPASS

echo kusanagi provision --WordPress --wplang ja --fqdn fqdn.of.host --email example@example.com --dbname $DB --dbuser $DBUSER --dbpass $DBPASS $NAME
