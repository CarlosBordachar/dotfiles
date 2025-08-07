#!/usr/bin/env bash

# Detiene el script si algún comando falla
set -euo pipefail

if [ "$(whoami)" == "root" ]; then
    exit 1
fi

########################################################################
# July 28 de 2025
# Script de instalación de KDE Plasma en Debian GNU/Linux 12 Bookworm.
# Partimos de una instalación mínima de Debian.
# Este script se ocupa de instalar:
# - KDE Plasma
# - Aplicaciones básicas
# - Pipewire
# - Flatpak
# - Bluetooth
# - Deshabilitar hibernación
# --------------
# NO hay riesgo si se ejecuta 2 o más veces el script.
########################################################################

silent_mode="-qq -y"


# Apps a instalar
apps=(
	# 0: base apps
    "git nala btop neofetch build-essential psmisc konsole kate firefox-esr qimgv unzip curl opensnitch"
    # 1: pipewire
    "pipewire pipewire-pulse wireplumber"
    # 2: multimedia
    "ffmpeg gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly mpv vlc v4l2loopback-dkms v4l-utils obs-studio gimp inkscape"
    # 3: commands
    "fzf bat"
)


# Install KDE Plasma, SM, and file manager.
install_KDE() {
	#### install plasma desktop ####
	echo "## 1. Install Plasma Desktop ##"

	# install kde plasma minimo (without bloated apps)
	sudo apt install $silent_mode plasma-desktop

	# install session manager sddm
	sudo apt install $silent_mode sddm

	# install file manager
	sudo apt install $silent_mode dolphin

	echo "FINISHED: 1. Install Plasma Desktop"
}


# Disable hibernate from start menu.
disable_hibernate() {
	#### disable hibernate ####
	echo "## 2. Disable Hibernate ##"

	# disable hibernate from start menu
	sudo systemctl mask hibernate.target hybrid-sleep.target

	echo "FINISHED: 2. Disable Hibernate"
}


# Install apps.
install_apps() {
	#### install apps ####
	echo "## 3. Install Basic Apps ##"
	# install base apps
	sudo apt install $silent_mode ${apps[0]}

	echo "## 3.1. Install Pipewire ####"
	# install pipewire
	sudo apt install $silent_mode ${apps[1]}

	# disable pulseaudio services
	systemctl --user --now disable pulseaudio.{socket,service}
	systemctl --user mask pulseaudio

	# enable pipewire services
	systemctl --user enable pipewire.{socket,service}

	echo "## 3.2. Install multimedia Apps ##"
	# install multimedia
	sudo apt install $silent_mode ${apps[2]}

	echo "## 3.3. Install commands ##"
	# install commands
	sudo apt install $silent_mode ${apps[3]}

	echo "## 3.4. Install Virt-Manager ##"
	# install virt-manager
	sudo apt install $silent_mode virt-manager bridge-utils

	# habilito el servicio vm
	sudo systemctl enable --now libvirtd

	echo "FINISHED: 3. Install Basic Apps"
}


# Install flatpak and obsidian from flatpak.
install_flatpak() {
	#### install flatpak ####
	echo "## 4. Install Flatpak ##"

	# install flatpak
	sudo apt install $silent_mode flatpak kde-config-flatpak

	# add flathub to flatpak
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	# install obsidian from flatpak
	flatpak install flathub md.obsidian.Obsidian

	echo "FINISHED: 4. Install Flatpak"
}


# Install bluetooth by pipewire.
install_bluetooth() {
	#### install pipewire bluetooth ####
	echo "## 5. Install Pipewire Bluetooth ##"

	# remove module from pulseaudio
	sudo apt remove $silent_mode pulseaudio-module-bluetooth

	sudo apt install $silent_mode libspa-0.2-bluetooth bluetooth

	# para el TP-Link UB500
	sudo apt install $silent_mode firmware-realtek

	echo "FINISHED: 5. Install Pipewire Bluetooth"
}


# Exit message.
exit_message() {
	echo "..."
	echo "..."
	echo "KDE Plasma Instalado"
	sleep 2
	echo "..."
	echo "Falta configurar lo siguiente:"
	echo "- Driver Nvidia (si se precisa) (script 02-install-nvidia.sh)"
	echo "- Credenciales de Github"
	echo "- Aplicar config de dotfiles (script 03-copy-dotfiles.sh)"
	echo "- Perfil de Firefox"
	echo "- Dotfiles de OBS-Studio"
	echo "- Dotfiles de Godot"
	echo "- Dotfiles de VSCode"
	echo "- Setear dotfiles repo en /home"
	echo "..."
	echo "Realizar un reinicio del sistema para finalizar los cambios."
	echo "Se recomienda iniciar sesión en KDE para que realice"
	echo "los seteos iniciales, salir y ejecutar el script siguiente."
	echo "..."
	echo "..."
	echo "A disfrutar del sistema!"
}



# Main entry point
clear
echo "Instalar KDE Plasma 5.27"
echo "Partiendo de una instalación mínima de"
echo "Debian GNU/Linux 12 - Bookworm - 64 bits."
echo "..."
echo "Ejecutar solo si ha leído el archivo README antes."
echo "Caso contrario, cancele (opción 3) y lea el README."
echo "..."
echo "Advertencia - Es un script sencillo que "
echo "requiere intervención para aceptar algunos comandos."
echo "Tiempo de instalación aproximado: 20 minutos"
echo "..."
echo "Este script realiza lo siguiente:"
echo "- 1. Instala KDE Plasma"
echo "- 2. Deshabilita la hibernación"
echo "- 3. Instala apps standard"
echo "- 4. Instala Flatpak"
echo "- 5. Instala Bluetooth"
echo "..."
echo "Para continuar debe elegir una opción:"
echo "1) Iniciar instalación"
echo "2) Ver aplicaciones a instalar"
echo "3) Salir del script sin hacer nada"

read -p "Indicar opción elegida (1-3): " input_option

case $input_option in
    1)
        echo "Ha seleccionado la Opción 1"
        ;;
    2)
        echo "Ha seleccionado la Opción 2"
        echo "Aplicaciones que se instalarán: ${apps[@]}"
        echo "Saliendo del script sin realizar ningún cambio..."
        exit 0
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

install_KDE
sleep 2
disable_hibernate
sleep 2
install_apps
sleep 2
install_flatpak
sleep 2
install_bluetooth
sleep 2
exit_message

exit 0
