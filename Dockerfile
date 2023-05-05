FROM mber5/broadway-baseimage:latest

ENV FAVICON_URL='https://raw.githubusercontent.com/virt-manager/virt-manager/931936a328d22413bb663e0e21d2f7bb111dbd7c/data/icons/256x256/apps/virt-manager.png'
ENV APP_TITLE='Virtual Machine Manager'
ENV CORNER_IMAGE_URL='https://raw.githubusercontent.com/virt-manager/virt-manager/931936a328d22413bb663e0e21d2f7bb111dbd7c/data/icons/256x256/apps/virt-manager.png'
ENV HOSTS="[]"
ENV DOMINIO=""
ENV HOST_DOMINIO_1=""
ENV HOST_DOMINIO_2=""

RUN apt-get update
RUN apt-get install -y --no-install-recommends virt-manager dbus-x11 libglib2.0-bin gir1.2-spiceclientgtk-3.0 ssh at-spi2-core libnginx-mod-http-auth-pam msktutil heimdal-clients libpam-heimdal 
RUN apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /root/.ssh
RUN echo "auth required pam_krb5.so \n\taccount required pam_krb5.so\n" >> /etc/pam.d/nginx
COPY arquives/config /root/.ssh/config
COPY arquives/startapp.sh /usr/local/bin/startapp
COPY arquives/krb5.conf /etc/krb5.conf
COPY arquives/default /etc/nginx/sites-available/default
CMD ["/usr/local/bin/startapp"]
