#!/bin/bash
# Run the broadwayd daemon and point nginx to it
/usr/local/bin/start
sed -i 's/$DOMINIO/'$DOMINIO'/' /etc/krb5.conf
sed -i 's/$HOST_DOMINIO_1/'$HOST_DOMINIO_1'/' /etc/krb5.conf
sed -i 's/%CORNER_IMAGE_URL%/'$CORNER_IMAGE_URL'/' /etc/nginx/sites-available/default
sed -i 's/%APP_TITLE%/'$APP_TITLE'/' /etc/nginx/sites-available/default
sed -i 's/%CORNER_IMAGE_URL%/'$CORNER_IMAGE_URL'/' /etc/nginx/nginx.tmpl
sed -i 's/%APP_TITLE%/'$APP_TITLE'/' /etc/nginx/nginx.tmpl
# Note: No X server or wayland support--only cli and gtk3
# ↓↓↓ PUT COMMANDS HERE ↓↓↓
dbus-launch gsettings set org.virt-manager.virt-manager.connections uris "$HOSTS"
dbus-launch gsettings set org.virt-manager.virt-manager.connections autoconnect "$HOSTS"
dbus-launch gsettings set org.virt-manager.virt-manager xmleditor-enabled true
tmux send-keys -t ttyd dbus-launch\ virt-manager\ --no-fork Enter
trap 'exit 0' SIGTERM
while true; do sleep 1; done