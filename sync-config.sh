#!/bin/bash

rsync -avP --delete ~/.config/kitty ./
rsync -avP --delete ~/.config/mpv ./
rsync -avP --delete ~/.config/wezterm ./
rsync -avP --delete ~/.config/starship ./
rsync -avP --delete ~/.zshrc ./zshrc/_zshrc
