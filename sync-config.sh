#!/bin/bash

rsync -avP --delete ~/.config/kitty ./
rsync -avP --delete ~/.config/mpv ./
rsync -avP --delete ~/.config/wezterm ./
rsync -avP --delete ~/.config/yazi ./
cat ~/.zshrc | grep -v 'API_KEY\|API KEY' >./zshrc/_zshrc
