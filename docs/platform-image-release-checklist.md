Seed Checklist that works in tandem with [platform-image.md](https://github.com/uaf-t3/t3x/blob/main/docs/platform-image.md) to ensure the current image can be ready for distribution.

- [ ] Delete browser data
  - Chromium > ... (top-right) > delete browsing data
  - Select "All Time" and leave all browsing data types checked.
  - Select "Delete from this device". Bookmarks will not be removed.
- [ ] Remove any existing ssh keys or authorizations
  - rm -r ~/.ssh/*
- [ ] t3x pi lockdown
- [ ] Ensure Node-RED is disabled on start
  - sudo systemctl disable nodered
- [ ] Disable / log out of any other software used
- [ ] Clear files from the following directories:
  - Desktop
  - Pictures
  - Trash
- [ ] Remove .bash_history from both root and pi
  - sudo rm /root/.bash_history
  - sudo rm ~/.bash_history
  - history -c
