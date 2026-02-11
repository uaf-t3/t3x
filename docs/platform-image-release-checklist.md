Seed Checklist that works in tandem with [platform-image.md](https://github.com/uaf-t3/t3x/blob/main/docs/platform-image.md) to ensure the current image can be ready for distribution.

- [ ] Remove .bash_history from both root and pi
- [ ] Clean up browser history
- [ ] Clear browser cache
- [ ] Ensure ~/.ssh/authorized_keys is empty
- [ ] Remove any .ssh/ public/private keys that may have been made
- [ ] Ensure SSH is disabled
- [ ] Ensure VNC is disabled
- [ ] Ensure Node-RED is disabled on start
- [ ] Clear Node-RED flows
- [ ] Ensure you’ve not turned on or logged into anything
- [ ] Clean up trash & other cruft that might be laying around