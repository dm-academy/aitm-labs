#!/bin/bash
# enable password logins
# WARNING Alters key config file.
# SECURITY HAZARD enables cleartext logins from internet
# this should be done only briefly during class initial setup during lab 0
# script needs to be run as sudo

sed -i -- "s/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g" /etc/ssh/sshd_config
sed -i -- "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config
sed -i -- "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
systemctl restart ssh