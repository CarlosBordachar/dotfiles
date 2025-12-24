alias ll='ls -lashFv --group-directories-first'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias gcd='cd "$(git rev-parse --show-cdup)"'

# -i : prompt before every removal
# -I : prompt once before removing more than three files, or when removing recursively;
#      less intrusive than -i, while still giving protection against most mistakes.
# Override with rm -f
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias cat='batcat --paging=never'
alias catplain='cat --style=plain'
alias fzfpreview='fzf --preview "batcat --decorations=always --color=always {}" --preview-window "~3"'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias dfl=dotfiles
alias webcam='mpv --demuxer-lavf-o=video_size=1280x720,input_format=mjpeg av://v4l2:/dev/video0 --profile=low-latency'
alias pkginstalled='zgrep " install " /var/log/dpkg.log* | sort -t ":" -k2.1 -k2.6 -k2.9'

# Alias para VSCodium en Wayland nativo (soluciona flickering Nvidia)
alias codium='codium --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations'

# keybindings for git with fzf. help: <Ctrl+G> <?>
source $HOME/.config/scripts/fzf-git.sh
