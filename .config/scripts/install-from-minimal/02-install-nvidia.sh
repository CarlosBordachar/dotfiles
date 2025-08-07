#!/usr/bin/env bash

# Detiene el script si algún comando falla
set -euo pipefail

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

########################################################################
# July 28 de 2025
# Script de instalación de Driver Nvidia en Debian GNU/Linux 12 Bookworm.
# Este script se ocupa de instalar:
# - Nvidia drivers (si asi se elige)
# --------------
# SI hay riesgo si se ejecuta 2 o más veces el script,
# porque para habilitar wayland se hace un agregado de instrucciones
# en el archivo /etc/modprobe.d/nvidia-options.conf
########################################################################

install_nvidia_driver=0
silent_mode="-qq -y"


# Install Nvidia drivers.
install_nvidia() {
	#### install nvidia driver ####
	echo "## 5. Install Nvidia Driver ##"

	# update kernel headers
	sudo apt install $silent_mode linux-headers-amd64

	if [ "$install_nvidia_driver" == 1 ]; then
	  # install driver proprietary (this is for GTX 750TI)
	  sudo apt install $silent_mode nvidia-driver firmware-misc-nonfree
	elif [ "$install_nvidia_driver" == 2 ]; then
	  # install driver proprietary (this is for RTX 2060)
	  sudo apt install $silent_mode nvidia-driver firmware-misc-nonfree nvidia-open-kernel-dkms
	fi

	if [[ "$install_nvidia_driver" == 1 || "$install_nvidia_driver" == 2 ]]; then
	  #### using wayland ####
	  # Enabled for Wayland
	  echo "options nvidia-drm modeset=1" | sudo tee --append /etc/modprobe.d/nvidia-options.conf

	  #### enable sleep and suspend function ####
	  # Fix glitch when restore after Sleep
	  echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" | sudo tee --append /etc/modprobe.d/nvidia-options.conf

	  # enable services sleep and resume after sleep.
	  sudo systemctl enable nvidia-suspend.service
	  sudo systemctl enable nvidia-resume.service
	fi

	echo "FINISHED: 5. Install Nvidia Driver"
}


# Exit message.
exit_message() {
	echo "..."
	echo "..."
	echo "Driver Nvidia Instalado"
	sleep 2
	echo "..."
	echo "Realizar un reinicio del sistema para finalizar los cambios."
	echo "..."
	echo "..."
	echo "A disfrutar del sistema!"
}



# Main entry point
clear
echo "Instalar Driver Nvidia en"
echo "Debian GNU/Linux 12 - Bookworm - 64 bits."
echo "..."
echo "Ejecutar solo si ha leído el archivo README antes."
echo "Caso contrario, cancele (opción 3) y lea el README."
echo "..."
echo "Advertencia - Es un script sencillo que "
echo "requiere intervención para aceptar algunos comandos."
echo "Tiempo de instalación aproximado: 5 minutos"
echo "..."
echo "Este script realiza lo siguiente:"
echo "- 1. Instala Nvidia drivers"
echo "..."
echo "Para instalar el driver Nvidia y continuar debe elegir una opción:"
echo "1) gtx750 : Nvidia GTX 750Ti - Proprietary driver (closed)"
echo "2) rtx2060 : Nvidia RTX 2060 - Open driver"
echo "3) Salir del script sin hacer nada"

read -p "Indicar opción elegida (1-3): " input_option

case $input_option in
    1)
        echo "Ha seleccionado la Opción 1"
        install_nvidia_driver=1
        ;;
    2)
        echo "Ha seleccionado la Opción 2"
        install_nvidia_driver=2
        ;;
    3)
        echo "Saliendo del script sin realizar ningún cambio..."
        exit 0
        ;;
    *)
        echo "Opción inválida. Intente nuevamente."
        exit 1
        ;;
esac

sudo apt update $silent_mode
sudo apt upgrade $silent_mode

install_nvidia
sleep 2
exit_message

exit 0
