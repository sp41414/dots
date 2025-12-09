#!/bin/bash

set -e

end() {
    echo "error: $1" >&2
    exit 1
}

install() {
    echo "=> $1"
    "./execs/$2" || echo "warning: $1 failed"
}

[[ -d ./execs ]] || end "execs directory not found"

install "base packages" arch
install "i3wm" i3
install "terminal" terminal
install "node stack" node
install "rust" rust
install "go" go
install "rofi" rofi
install "discord" discord
install "extras" extra

echo "=> configs"
read -rp "backup ~/.config? [Y/n] " ans
case "${ans:-y}" in
    [Yy]*|"") 
        [[ -d ~/.config ]] && mv ~/.config ~/.config.bak.$(date +%s)
        ;;
    [Nn]*) 
        rm -rf ~/.config
        ;;
esac

mkdir -p ~/.config
cp -r ./dots/.config/* ~/.config/

install "tmux" tmux

echo "=> scripts"
read -rp "backup ~/.local/scripts? [Y/n] " ans
case "${ans:-y}" in
    [Yy]*|"") 
        [[ -d ~/.local/scripts ]] && mv ~/.local/scripts ~/.local/scripts.bak.$(date +%s)
        ;;
    [Nn]*) 
        rm -rf ~/.local/scripts
        ;;
esac
mkdir -p ~/.local/scripts
cp -r ./dots/.local/scripts/* ~/.local/scripts/

echo "done"
