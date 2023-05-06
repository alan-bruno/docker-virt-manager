FROM alanbruno/broadway-ubuntu:latest

ENV FAVICON_URL='https://raw.githubusercontent.com/virt-manager/virt-manager/931936a328d22413bb663e0e21d2f7bb111dbd7c/data/icons/256x256/apps/virt-manager.png'
ENV APP_TITLE='Virtual Machine Manager'
ENV CORNER_IMAGE_URL='https://raw.githubusercontent.com/virt-manager/virt-manager/931936a328d22413bb663e0e21d2f7bb111dbd7c/data/icons/256x256/apps/virt-manager.png'
ENV HOSTS="[]"
ENV DOMINIO=""
ENV HOST_DOMINIO_1=""
ENV HOST_DOMINIO_2=""

RUN mkdir -p /root/.ssh
RUN echo "auth required pam_krb5.so \n\taccount required pam_krb5.so\n" >> /etc/pam.d/nginx
COPY files/config /root/.ssh/config
COPY files/startapp.sh /usr/local/bin/startapp
COPY files/krb5.conf /etc/krb5.conf
#Authentication via Active Directory
COPY files/default_AD /etc/nginx/sites-available/default
COPY files/default_AD /etc/nginx/nginx.tmpl
#Authentication via Usuário common
#COPY files/default_US /etc/nginx/sites-available/default
#COPY files/default_US /etc/nginx/nginx.tmpl
RUN  chmod +x /usr/local/bin/startapp
CMD ["/usr/local/bin/startapp"]
