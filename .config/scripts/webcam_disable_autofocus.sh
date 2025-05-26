#!/bin/sh

# Disable autofocus en webcam.
# Mi webcam Logitech C920 HD Pro no persiste el cambio del autofocus
# por ello hay que setearlo cada vez que se conecta o inicia sesión.
# Este script es invocado por la regla creada en
# /etc/udev/rules.d/99-logitech-c920-default-focus.rules
#
# Dicha regla tiene el siguiente código
# SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTR{index}=="0", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="082d", SYMLINK+="webcam_c920"
# SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTR{index}=="0", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="082d", RUN+="/home/debian/carlos/.config/scripts/webcam_disable_autofocus.sh $devnode"
#
# La regla crea el alias "webcam_c920" para la webcam y le indica ejecutar el script.
# Cada vez que se conecte la camara se ejecutará.
# Supuestamente al iniciar el equipo también lo ejecuta, pero no veo los cambios reflejados,
# es por ello que hago la invocación a este script desde ~/.profile
#
# Vemos los parámetros que soporta nuestra cámara con:
# v4l2-ctl -d /dev/video0 --list-ctrls
#
# Los comandos consisten en dehabilitar el autofocus y luego setear el focus.
# No lo hacemos todo en una sola instrucción
# porque falla al intentar setear el focus particular
# ya que aún no se encuentra deshabilitado el autofocus
# (es cierto, dado que lo hacemos todo en una misma instrucción).
# Por eso es que lo hacemos en dos invocaciones.
#
# Este script es probable que a futuro pasa a estar en /usr/local/bin

# Comandos

device=$1
autofocus_active=0
focus_value=15 # 15 es la distancia del focus
# (los valores que me funcionan bien son 15, 20, 25 mas/menos (de 5 en 5).
# 15: arriba del monitor
# 25: en el soporte
# mayor número, focus mas cercano a la camara.


# si se pasó por parámetro el path del dispositivo entonces se ejecuta.
if [[ -e $device ]]; then
    #v4l2-ctl -d /dev/video0 --set-ctrl=focus_auto=0
    #esta linea en el modelo c920 HD Pro no funciona porque no existe ese parametro con ese nombre,
    #sino que el nombre es el de abajo: focus_automatic_continuous.

    v4l2-ctl -d $device --set-ctrl=focus_automatic_continuous=$autofocus_active

    v4l2-ctl -d $device --set-ctrl=focus_absolute=$focus_value
fi

# Exit or Return
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
  # Script sourced
  return 0
else
  # Script ejecutado
  exit 0
fi
