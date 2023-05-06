#!/bin/bash
# Run the broadwayd daemon and point nginx to it
/usr/local/bin/start
sed -i 's/$DOMINIO/'$DOMINIO'/' /etc/krb5.conf
sed -i 's/$HOST_DOMINIO_1/'$HOST_DOMINIO_1'/' /etc/krb5.conf
sed -i 's/$HOST_DOMINIO_2/'$HOST_DOMINIO_2'/' /etc/krb5.conf
# Note: No X server or wayland support--only cli and gtk3
# ↓↓↓ PUT COMMANDS HERE ↓↓↓
dbus-launch gsettings set org.virt-manager.virt-manager.connections uris "$HOSTS"
dbus-launch gsettings set org.virt-manager.virt-manager.connections autoconnect "$HOSTS"
dbus-launch gsettings set org.virt-manager.virt-manager xmleditor-enabled true
while true; 
do 
ps -C virt-manager > /dev/null
if [ $? = 0 ]
then
sleep 1
else
dbus-launch virt-manager --no-fork
fi
sleep 10; 
done
trap 'exit 0' SIGTERM
