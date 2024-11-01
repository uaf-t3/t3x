# t3x autolaunch helpers

Provide a quick way to get things automatically launching:
- on reboot
- on graphical desktop login
- on a daily / weekly / monthly schedule

## Details

### Graphical Desktop Login (lxde)

Default Raspberry Pi's are configured to use LXDE as the window manager after being launched by the login manager (lightdm). 

LXDE will looks autolaunch details in the users `.config/lxsession/LXDE-pi/autostart`

We take advantage of that to launch our helper script that then launches all the scripts in the users's `$HOME/Documents/Autolaunch/lxsession/`.   This means you put a new shell script with a .sh extension in that folder and it will be run on when the graphical desktop is launched, which automatically happens by on a default Raspberry Pi OS configuration.

### On reboot

TODO

### on daily/weekly/monthly

TODO

## Tasks

### Setup

```
./setup.sh
```

