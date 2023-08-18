#!/bin/bash

if [ $(crontab -l | wc -c) -eq 0 ];
then
  touch /tmp/cronnew
else
crontab -l > /tmp/cronnew  >> /dev/null 2>&1
fi


echo "0 11 30 * * /opt/web_cert/docker.sh > /dev/null 2>&1" >> /tmp/cronnew
echo "*/5 * * * * rm /tmp/*.tar.gz" >> /tmp/cronnew

crontab /tmp/cronnew >> /dev/null 2>&1
rm /tmp/cronnew