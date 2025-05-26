#!/bin/bash

# Set defaults en webcam.
# Mi webcam Logitech C920 HD Pro no persiste el cambio del
# autofocus, autoexposure y autowhitebalance,
# por ello hay que setearlos cada vez que se conecta o inicia sesión.
# Este script es invocado por la regla creada en
# /etc/udev/rules.d/99-logitech-c920-set-defaults.rules
#
# Dicha regla tiene el siguiente código
# SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTR{index}=="0", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="082d", SYMLINK+="webcam_c920"
# SUBSYSTEM=="video4linux", KERNEL=="video[0-9]*", ATTR{index}=="0", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="082d", RUN+="/home/debian/carlos/.config/scripts/webcam_set_defaults.sh $devnode"
#
# La regla crea el alias "webcam_c920" para la webcam y le indica ejecutar el script.
# Cada vez que se conecte la camara se ejecutará.
# Supuestamente al iniciar el equipo también lo ejecuta, pero no veo los cambios reflejados,
# es por ello que hago la invocación a este script desde ~/.profile
#
# Vemos los parámetros que soporta nuestra cámara con:
# v4l2-ctl -d /dev/video0 --list-ctrls
#
# Los comandos consisten en dehabilitar todos los autos (autofocus, autoexposure y autowhitebalance)
# y luego setearlos a mano.
# No lo hacemos todo en una sola instrucción
# porque falla al intentar setear los valores particulares
# ya que aún no se encuentran deshabilitados los autos-x.
# Por eso es que lo hacemos en dos invocaciones.
#
# Este script es probable que a futuro pasa a estar en /usr/local/bin

##############
# Parameters #
##############
device="/dev/webcam_c920"   # internal. Default device.
b_day=0                     # Light mode. Para cuando está muy iluminado el ambienta (de día) usar este modo que baja el brillo.
b_zoom=0                    # Zoom mode. Aplica el máximo zoom posible soportado por la webcam.
s_params_info="Parameters allowed:
    -d    Device path. Requires argument.
          (ex: -d /dev/video0)
    -n    Normal Mode: Night and No Zoom. No requires argument.
    -l    Light Mode: Day. No requires argument.
    -z    Zoom Mode. No requires argument.
    -h    This info. Parameters allowed."


# Si no hay parametros ni flag ni nada, muestro info como invocar script.
if [[ $# == 0 ]]; then
  echo "$s_params_info" >&2
  exit 1
fi

# Valid flags
# -d : device
# -l : light : b_day
# -z : zoom : b_zoom
while getopts ":d:nlzh" opt; do
  case $opt in
    d) device=$OPTARG ;;    # flag -d con argumento
    n) b_day=0; b_zoom=0 ;; # flag -n
    l) b_day=1 ;;           # flag -l
    z) b_zoom=1 ;;          # flat -z
    h) echo "$s_params_info" >&2; exit 1 ;;
    \?) echo "Invalid option: -$OPTARG | $s_params_info" >&2; exit 1 ;;
    :) echo "Parameter -$OPTARG requires an argument." >&2; exit 1 ;;
  esac
done

# Eliminar los argumentos ya procesados por el getopts
shift "$((OPTIND -1))"

# Si hay 1 parametro sin flag, asumo que es el device.
if [[ $# == 1 ]]; then
  device=$1
fi

# Si hay 2 o más parámetros sin flag, informo que los pase usando flags.
if [[ $# -ge 2 ]]; then
  echo "Error: Parameter not found.
    $s_params_info" >&2
  exit 1
fi

####################
# Camera Variables #
####################

brightness_value=135
contrast_value=135
saturation_value=128                    # same default

white_balance_automatic_value=0
gain_value=200                          # de noche valor 200. De día con mucha iluminación valor 110.
if [[ "$b_day" == 1 ]]; then
  gain_value=110;
fi

power_line_frequency_value=2            # same default

white_balance_temperature_value=4500
sharpness_value=128                     # same default
backlight_compensation_value=0          # same default

auto_exposure_value=1                   # Manual Mode
exposure_time_absolute_value=250        # same default
exposure_dynamic_framerate_value=0      # same default
pan_absolute_value=0                    # same default
tilt_absolute_value=0                   # same default

focus_automatic_continuous_value=0
focus_absolute_value=15                 # 15 es la distancia del focus
                                        # (los valores que me funcionan bien son 15, 20, 25 mas/menos (de 5 en 5).
                                        # 15: arriba del monitor
                                        # 25: en el soporte
                                        # mayor número para focus mas cercano a la camara.
zoom_absolute_value=100                 # same default
if [[ "$b_zoom" == 1 ]]; then
  zoom_absolute_value=120;
fi

###########################
# Params to set in groups #
###########################
params1=white_balance_automatic=$white_balance_automatic_value\
,auto_exposure=$auto_exposure_value\
,focus_automatic_continuous=$focus_automatic_continuous_value\
,power_line_frequency=$power_line_frequency_value\

params2=brightness=$brightness_value\
,contrast=$contrast_value\
,saturation=$saturation_value\
,gain=$gain_value\
,white_balance_temperature=$white_balance_temperature_value\
,sharpness=$sharpness_value\
,backlight_compensation=$backlight_compensation_value\
,exposure_time_absolute=$exposure_time_absolute_value\
,exposure_dynamic_framerate=$exposure_dynamic_framerate_value\
,pan_absolute=$pan_absolute_value\
,tilt_absolute=$tilt_absolute_value\
,focus_absolute=$focus_absolute_value\
,zoom_absolute=$zoom_absolute_value

############
# Commands #
############
# si se pasó por parámetro el path del dispositivo entonces se ejecuta.
if [[ -e $device ]]; then

    v4l2-ctl -d $device --set-ctrl $params1

    v4l2-ctl -d $device --set-ctrl $params2

fi

# Exit or Return
if [[ "${BASH_SOURCE[0]}" != "${0}" ]]; then
  # Script sourced
  return 0
else
  # Script ejecutado
  exit 0
fi
