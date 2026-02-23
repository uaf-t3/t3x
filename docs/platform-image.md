<!-- The steps taken to customize the default Raspberry Pi OS for T3 use as a T3X image. -->
## Steps Taken to Customize Default RPiOS for T3 use as a T3X Image.

- [ ] Install & Bootstrap T3X
  - Follow the [installation instructions](https://github.com/uaf-t3/t3x/tree/main).
  - Packages from [packages.txt](https://github.com/uaf-t3/t3x/blob/main/lib/packages.txt) will be downloaded by [sanity.t3x](https://github.com/uaf-t3/t3x/blob/main/scripts/sanity.t3x).
 
- [ ] Enable Zram
  - t3x zram-setup
  - This allows Raspberry Pi to use more flash storage space as virtual memory, improving performance.
    
- [ ] Enable I2C
  - (preferences > interfaces > I2C) or use "sudo raspi-config nonint do_i2c 0"
  - This allows Raspberry Pi to use I2C sensors including BME280.
     
- [ ] Install Node-RED
  - t3x nodered setup
  - Node-RED is used for T3 programming curriculum.
     
- [ ] Setup Starship
  - t3x starship setup
  - This improves the terminal prompt.
     
- [ ] Fix the chromium keyring popup
  - Edit the file "usr/share/applications/x-www-browser.desktop" (requires elevated permission to write - try "sudo nano usr/share/applications/x-www-browser.desktop")
  - Locate the line "Exec=x-www-browser %u" and replace "%u" with "--password-store=basic"
  - If using nano, CTRL+S to save and CTRL+X to exit.

- [ ] Set up Chromium Homepage and Bookmarks
  - Homepage may be set to https://t3.alaska.edu/
  - Bookmarks may be set to Node-Red Flow Editor (http://localhost:1880/), Node-Red Dashboard (http://localhost:1880/ui), and T3 Alaska (https://t3.alaska.edu/)

- [ ] Change Wallpaper
  - Go to the start menu and click "Preferences > Appearance Settings".
  - Click on “Picture” and select your desired wallpaper image.
  - This menu can be used to change the OS theme (optional).
     
- [ ] Erase your footprints
  - Complete applicable steps from [Platform-Image-Release-Checklist](https://github.com/uaf-t3/t3x/blob/main/docs/platform-image-release-checklist.md).
