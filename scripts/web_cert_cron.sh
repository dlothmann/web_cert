#!/bin/bash

crontab -l > /tmp/cronnew

echo "0 11 30 * * /opt/web_cert/docker.sh > /dev/null 2>&1" >> /tmp/cronnew
echo "*/5 * * * * rm /tmp/*.tar.gz" >> /tmp/cronnew

crontab /tmp/cronnew
rm /tmp/cronnew


