#!/usr/bin/env bash

# Detiene el script si algún comando falla
set -euo pipefail

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

########################################################################
# July 28 de 2025
# Script de configuración de KDE Plasma en Debian GNU/Linux 12 Bookworm.
# Requisitos:
# - Ya instaladas las apps del script anterior (01-install-apps.sh).
# Este script se ocupa de configurar usando los dotfiles:
# - Install Starship prompt
# - Dotfiles
# - Nerdfonts
# - Udev para webcam
# --------------
# SI hay riesgo si se ejecuta 2 o más veces el script,
# porque para habilitar la regla udev para la webcam se hace un agregado
# en el archivo /etc/udev/rules.d/99-logitech-c920-set-defaults.rules
########################################################################

silent_mode="-qq -y"
url_starship="https://starship.rs/install.sh"
url_dotfiles="https://github.com/CarlosBordachar/dotfiles.git"
branch_dotfiles="debian12-kde"


# Install starship.
install_starship() {
	#### install starship ####
	echo "## 1. Install Starship ##"

	cd /tmp/
	curl -sS $url_starship | sh

	echo "FINISHED: 1. Install Starship"
}


# Copy configs from dotfiles in respository.
copy_dotfiles() {
	#### dotfiles ####
	echo "## 2. Download dotfiles ##"

	cd /tmp/
	mkdir -p /tmp/dotfiles
	rm -rf /tmp/dotfiles/*
	cd /tmp/dotfiles

	# download dotfiles
	git clone $url_dotfiles .
	git checkout $branch_dotfiles

	# copy all files except .git directory to home
	rsync -av --exclude=".git" ./ ~/

	# refresh bat cache for new themes copied.
	batcat cache --build

	echo "FINISHED: 2. Download dotfiles"
}


# Install nerdfonts from script.
install_nerdfonts() {
	#### install nerdfonts ####
	echo "## 3. Install NerdFonts ##"

	cd
	bash ~/.config/scripts/nerdfont_download.sh

	echo "FINISHED: 3. Install NerdFonts"
}


# Create udev rule for webcam Logitech C920.
config_udevwebcam() {
	#### config udev webcam logitech ####
	echo "## 4. Config udev webcam Logitech ##"

	scripts_directory=$HOME/.config/scripts

	echo "SUBSYSTEM==\"video4linux\", KERNEL==\"video[0-9]*\", ATTR{index}==\"0\", ATTRS{idVendor}==\"046d\", ATTRS{idProduct}==\"082d\", SYMLINK+=\"webcam_c920\"
SUBSYSTEM==\"video4linux\", KERNEL==\"video[0-9]*\", ATTR{index}==\"0\", ATTRS{idVendor}==\"046d\", ATTRS{idProduct}==\"082d\", RUN+=\"$scripts_directory/webcam_set_defaults.sh \$devnode\"" | sudo tee --append /etc/udev/rules.d/99-logitech-c920-set-defaults.rules

	echo "FINISHED: 4. Config udev webcam Logitech"
}


# Exit message.
exit_message() {
	echo "..."
	echo "..."
	echo "KDE Plasma Configurado"
	sleep 2
	echo "..."
	echo "Falta configurar lo siguiente:"
	echo "- Perfil de Firefox"
	echo "- Dotfiles de OBS-Studio"
	echo "- Dotfiles de Godot"
	echo "- Dotfiles de VSCode"
	echo "- Setear dotfiles repo en /home"
	echo "..."
	echo "Realizar un reinicio del sistema para finalizar los cambios."
	echo "..."
	echo "..."
	echo "A disfrutar del sistema ya configurado!"
}


# Main entry point
clear
echo "Configurar KDE Plasma"
echo "Sobre una instalación de KDE Plasma 5.27 en"
echo "Debian GNU/Linux 12 - Bookworm - 64 bits."
echo "..."
echo "Ejecutar solo si ha leído el archivo README antes."
echo "Caso contrario, cancele (opción 2) y lea el README."
echo "..."
echo "Advertencia - Es un script sencillo que "
echo "requiere intervención para aceptar algunos comandos."
echo "Tiempo de instalación aproximado: 5 minutos"
echo "..."
echo "Este script realiza lo siguiente:"
echo "- 1. Instala Starship"
echo "- 2. Copia dotfiles"
echo "- 3. Instala fuentes NerdFonts"
echo "- 4. Configura regla de UDev para webcam Logitech C920"
echo "..."
echo "Para ejecutar el script debe elegir una opción:"
echo "1) Continuar y configurar"
echo "2) Salir del script sin hacer nada"

read -p "Indicar opción elegida (1-2): " input_option

case $input_option in
    1)
        echo "Ha seleccionado la Opción 1"

		sudo apt update $silent_mode
		sudo apt upgrade $silent_mode

		install_starship
		sleep 2
		copy_dotfiles
		sleep 2
		install_nerdfonts
		sleep 2
		config_udevwebcam
		sleep 2
		exit_message
        ;;
    2)
        echo "Saliendo del script sin realizar ningún cambio..."
        ;;
    *)
        echo "Opción inválida. Intente nuevamente."
        exit 1
        ;;
esac

exit 0
