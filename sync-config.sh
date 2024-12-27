#!/bin/bash

rsync -avP --delete ~/.config/kitty ./
rsync -avP --delete ~/.config/mpv ./
rsync -avP --delete ~/.config/wezterm ./
rsync -avP --delete ~/.config/yazi ./
rsync -avP --delete ~/.config/ghostty ./

cat ~/.zshrc | grep -v 'API_KEY\|API KEY' >./zshrc/_zshrc

mkdir -p ./tmux
cp -f ~/.tmux.conf ./tmux/_tmux.conf
