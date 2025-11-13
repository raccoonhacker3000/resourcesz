#!/bin/bash

source ./colors.sh

PrintLightBlue "Initialize UFW"
ufw enable
ufw logging on
ufw logging high
ufw default deny incoming
ufw default allow outgoing

sed -i "s/DEFAULT_FORWARD_POLICY=.*/DEFAULT_FORWARD_POLICY=\"DROP\"/" /etc/default/ufw
sed -i "s/IPV6=.*/IPV6=no/" /etc/default/ufw

ufw reload

PrintGreen "Firewall Enabled"