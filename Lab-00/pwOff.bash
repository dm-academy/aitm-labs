#!/bin/bash
# WARNING Alters key config file.
# Turns password authentication back off. (the way we want it)


sed -i -- "s/ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/g" /etc/ssh/sshd_config
sed -i -- "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config
sed -i -- "s/PasswordAuthentication yes/PasswordAuthentication no/g" /etc/ssh/sshd_config
systemctl restart ssh