# Custom script to open links/urls
The main idea is to prevent tracking & pages with lot of cookies in the main browser (tested in Gnome 41.2)

## Install
```bash
cp custom-open-link.desktop ~/.local/share/applications/custom-open-link.desktop
cp config.example.yml config.yml
```

## Edit default mimeapp
- Edit `~/.config/mimeapps.list` or `~/.local/share/applications/mimeapps.list`
- Change under `[Added Associations]`
  - x-scheme-handler/http=custom-open-link.desktop;
  - text/html=custom-open-link.desktop;
  - x-scheme-handler/https=custom-open-link.desktop;

## Change config
- `default`: Default browser command
- `private`: Default private browser command (default command for unknown domains)
- `drop_params`: Url/domains to drop params (to skip "traking")
- `custom_domains`: `command: domains/urls*` mapping for custom url => browser

## Restart Gnome
