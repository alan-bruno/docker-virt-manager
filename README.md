# Docker virt-manager - Authentication via Active Directory
## Connection private key connection only
### GTK Broadway web UI for libvirt
![Docker virt-manager](docker-virt-manager.gif)

## What is it? 
virt-manager: https://virt-manager.org/  
broadway: https://developer.gnome.org/gtk3/stable/gtk-broadway.html


## Features:
* Uses GTK3 Broadway (HTML5) backend--no vnc, xrdp, etc needed!
* Password/SSH passphrase support via ttyd (thanks to [@obazda20](https://github.com/obazda20/docker-virt-manager) for the idea!) Just click the terminal icon at the bottom left to get to the password prompt after adding an ssh connection. 

## Requirements:
git, docker, docker-compose, at least one libvirt/kvm host

## Usage

### docker-compose

If docker and libvirt are on the same host or different hosts
```yaml
version: '3'

networks:
  virt-manager:
    driver:
      bridge

services:  
  virt-manager:
    build:
      dockerfile: ./DockerFile
      context: .
    container_name: virt-manager
    image: docker-virt-manager
    restart: always
    ports:
      - 8185:80
    networks:
      - virt-manager
    environment:
      # Set HOSTS: "['qemu:///session']" to connect to a user session
      # If you want to access other machines, leave HOSTS: "[]"
      HOSTS: "[]"
      # If you want to authenticate via AD, inform the domain
      DOMINIO: ""
      # enter the ip of the domain controller server
      HOST_DOMINIO_1: ""
      # If you have more than one, please enter below.
      HOST_DOMINIO_2: ""
      # OBS: If you have more than two domain controllers, 
      # modify the krb5.conf file, inside the "files" folder
      
    volumes:
      - ./keys/chave.pem:/root/.ssh/chave.pem:ro
```
## If you are not going to use authentication via Active Directory, modify the Dockerfile file, leaving it as below

<img width="114" alt="" src="https://uploaddeimagens.com.br/imagens/HsvfRx4">

### How to create a common user

```bash
    htpasswd -c /etc/nginx/.htpasswd user
    # To create additional user accounts, use the following command.
    htpasswd /etc/nginx/.htpasswd user
```
## Building from Dockerfile

```bash
    git clone https://github.com/m-bers/docker-virt-manager.git
    cd docker-virt-manager
    docker build -t docker-virt-manager . && docker-compose up -d
```
Go to http://localhost:8185 in your browser
