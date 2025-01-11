# My DotFiles

### Install

```bash
git clone ~/.dotfiles
sudo apt-get install zsh ack vim
cd .dotfiles
rake install
```

#### Enjoy

## Notes:

### Smplayer:
mpv options =>
`--hr-seek-framedrop=no --script=/home/rotsen/.config/mpv/scripts/trakt-mpv.lua`
mpv script =>
https://github.com/mpv-player/mpv/wiki/User-Scripts  (Search for trakt)

### Gromit-MPX (screen drawns)
`cp gromit-mpx.cfg ~/.config/gromit-mpx.cfg`

### Gnome custom settings
// Disable recent files
dconf-editor , navigate to org->gnome->desktop->privacy and uncheck the remember-apps & remember-recent-files key
// Disable tracker
```bash
systemctl --user mask tracker-store.service tracker-extract-3.service tracker-extract.service tracker-miner-apps.service tracker-miner-fs-3.service tracker-miner-fs-control-3.service) tracker-miner-fs.service tracker-miner-rss-3.service tracker-miner-rss.service tracker-writeback-3.service tracker-writeback.service tracker-xdg-portal-3.service
tracker3 reset --filesystem --rss
```

### Firefox extensions
- [https://addons.mozilla.org/es/firefox/addon/torrent-control/](Torrent Control)
- [https://addons.mozilla.org/es/firefox/addon/gnome-shell-integration/Gnome](integration)
- [https://addons.mozilla.org/es/firefox/addon/ublock-origin/](uBlock origin)

### Gnome extensions
- [https://extensions.gnome.org/extension/307/dash-to-dock/](Dash to Dock)
- [https://extensions.gnome.org/extension/36/lock-keys/](Lock keys)
- [https://extensions.gnome.org/extension/3724/net-speed-simplified/](Netspeed)
- [https://extensions.gnome.org/extension/7/removable-drive-menu/](Removable Drive)
- [https://extensions.gnome.org/extension/4548/tactile/](Tactile window-grid)
- [https://extensions.gnome.org/extension/2890/tray-icons-reloaded/](Tray icons)
- [https://extensions.gnome.org/extension/1460/vitals/](Vitals - system monitor)


## utils / tools
All the shit that can't run in docker that I [could] use

- [Key-mon](https://github.com/scottkirkwood/key-mon/) A screencast utility that displays your keyboard and mouse status
- [Opti](https://github.com/torcado194/opti) Transparent render images in desktop over everything else
- [Elixir-ls](https://github.com/elixir-lsp/elixir-ls) Elixir server for vim-lint
- [JJ](https://github.com/tidwall/jj) fast JSON cli manager
- [msrsync](https://github.com/jbd/msrsync) Parallel RSYNC script in python2.6
