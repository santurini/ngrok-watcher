# Usage

Fetches ngrok url, and pushes it to this repo.

### Add path to script

Modify [main.sh](https://github.com/santurini/ngrok-watcher/blob/main/main.sh), like this:
```
[Unit]
Description=Loop which uploads Ngrok URL to GitLab repo

[Service]
ExecStart=/path/to/script/main.sh

[Install]
WantedBy=default.target
```

### Installation as system unit

For automatic execution on boot, restart on failure & logging with systemd, you need to create a Systemd User Unit.

The unit file is present in `./ngrok-watcher.service`, you just need to copy it under `~/.config/systemd/user/`

```
cp ngrok-watcher.service ~/.config/systemd/user/

# enable on boot (does not start it)
systemctl --user enable ngrok-watcher

# start it now
systemctl --user start ngrok-watcher

# check status
systemctl --user status ngrok-watcher
```

