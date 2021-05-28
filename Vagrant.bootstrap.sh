#!/bin/bash

#Aprovisionamiento de software

#Actualizo los paquetes disponibles de la VM
sudo apt-get update -y

#Desintalo el servidor web instalado previamente en la unidad 1,
# a partir de ahora va a estar en un contenedor de Docker.
if [ -x "$(command -v apache2)" ];then
	sudo apt-get remove --purge apache2 -y
	sudo apt autoremove -y
fi

# Directorio para los archivos de la base de datos MySQL. El servidor de la base de datos
# es instalado mediante una imagen de Docker. Esto está definido en el archivo
# docker-compose.yml
if [ ! -d "/var/db/mysql" ]; then
	sudo mkdir -p /var/db/mysql
fi

# Muevo el archivo de configuración de firewall al lugar correspondiente
if [ -f "/tmp/ufw" ]; then
	sudo mv -f /tmp/ufw /etc/default/ufw
fi

##Swap
##Genero una partición swap. Previene errores de falta de memoria
if [ ! -f "/swapdir/swapfile" ]; then
	sudo mkdir /swapdir
	cd /swapdir
	sudo dd if=/dev/zero of=/swapdir/swapfile bs=1024 count=2000000
	sudo mkswap -f  /swapdir/swapfile
	sudo chmod 600 /swapdir/swapfile
	sudo swapon swapfile
	echo "/swapdir/swapfile       none    swap    sw      0       0" | sudo tee -a /etc/fstab /etc/fstab
	sudo sysctl vm.swappiness=10
	echo vm.swappiness = 10 | sudo tee -a /etc/sysctl.conf
fi


# Configuración applicación
# ruta raíz del servidor web
APACHE_ROOT="/var/www"
# ruta de la aplicación
APP_PATH="$APACHE_ROOT/utn-devops-app/"
API_PATH="$APACHE_ROOT/utn-devops-api/"

# descargo la app del repositorio
if [ ! -d  $APACHE_ROOT ]; then
	sudo mkdir $APACHE_ROOT
fi
cd $APACHE_ROOT
sudo git clone https://github.com/alesacchi/utn-devops.git utn-devops
sudo git clone https://github.com/alesacchi/utn-devops.git utn-devops-app
sudo git clone https://github.com/alesacchi/utn-devops.git utn-devops-api
cd $APP_PATH
sudo git checkout app
cd $API_PATH
sudo git checkout api

######## Instalacion de DOCKER ########
#
# Esta instalación de docker es para demostrar el aprovisionamiento
# complejo mediante Vagrant. La herramienta Vagrant por si misma permite
# un aprovisionamiento de container mediante el archivo Vagrantfile. A fines
# del ejemplo que se desea mostrar en esta unidad que es la instalación mediante paquetes del
# software Docker este ejemplo es suficiente, para un uso más avanzado de Vagrant
# se puede consultar la documentación oficial en https://www.vagrantup.com
#
if [ ! -x "$(command -v docker)" ]; then
	sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

	##Configuramos el repositorio
	curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" > /tmp/docker_gpg
	sudo apt-key add < /tmp/docker_gpg && sudo rm -f /tmp/docker_gpg
	sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

	#Actualizo los paquetes con los nuevos repositorios
	sudo apt-get update -y

	#Instalo docker desde el repositorio oficial
	sudo apt-get install -y docker-ce docker-compose

	#Lo configuro para que inicie en el arranque
	sudo systemctl enable docker
fi

# Inicio docker-compose
cd /vagrant/docker
sudo docker-compose up -d