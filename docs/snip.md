# `t3x/bin/snip`

The `t3x/bin/snip` script does the following:
- waits 1 second
- uses `slurp` + `grim`
- saves as JPEG with timestamp
- verifies dependencies (slurp, grim, convert, feh)
- saves to ~/Pictures if it exists, otherwise ~
- automatically opens the result with feh

## TODO

- [ ] create a labwm key binding
- [ ] create flag for copy to clipboard instead of save to file (wl-copy)
  - [ ] second labwm key binding
