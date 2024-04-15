# T3X
The cuddly waffle toolset for T3 Raspberry Pi image creation & maintenance.

> TODO words that set the context of this project and its role in the Alaska T3 program
> & T3 Alliance RPi ecosystem

## Installation

Fully manual clone steps:
```
git clone git@github.com:uaf-t3/t3x
cd t3x
# review the scripts starting with bootstrap.sh
./scripts/bootstrap.sh
```

Trust the T3X CHEESE lab team? Recommended easy method:
```
curl https://raw.github.com/uaf-t3/t3x/main/scripts/bootstrap.sh | bash -e
```

## `t3x` Usage

The `t3x` command offers an interface to a collection of scripts and tools.

### Scripts

#### `scripts/bootstrap.sh` 
Gets t3x installed & into a good state by the following steps:
- verify functional access to the Internet
- ensures basic tools needed for bootstrap (git) are available
- Fetches latest version of t3x `main` branch. 
- Setup `$HOME/.bash.d` folder. TODO: Wiki page on this!  
- Use `.bash.d/t3x.sh` to ensure `$HOME/t3x/bin` is in `$PATH`

#### `scripts/

### Tools

#### `t3x pi` 
Tools to manage our pi.  Includes fun gems like:
- [ ] `t3x pi setup`
  - [ ] `t3x pi update`
  - [ ] `t3x pi sanity`
  - [x] `t3x pi wallpaper`
- [ ] `t3x pi lockdown`
  - [ ] runs setup (and steps involved there)
  - [ ] installs and setups firewall

#### `t3x starship`

A tool to ensure our T3 RPis have a cool custom prompt and fonts for maximum enjoyment.  See the [tools/starship/README.md](./tools/starship/README.md) for more details.  

`t3x starship setup`
- Installs & configures [starship.sh](https://starship.sh)
- Ensures the LxTerminal is using a NerdFont (required for advanced prompts)
- Future TODO include bash-completion and other advanced shells

`t3x starship launch`
- Bonus launch features

## License

We want this tool to be available for T3 sites and others to use under an 
open-source license. We picked the [Apache 2.0 license](https://choosealicense.com/licenses/apache-2.0/) 
that provides the following features to users. Any contributions to this project
must be eligible to be included under this license or as needed; any specific file must clearly be labeled if they fall under different licensing restrictions. 

| Permissions | Conditions | Limitations |
| ----------- | ---------- | ----------- | 
| :green_circle: Commercial Use | :large_blue_circle: License & copyright notice | :red_circle: Liability |
| :green_circle: Distribution   | :large_blue_circle: State changes | :red_circle: Trademark use |
| :green_circle: Modification   | :memo:   | :red_circle: Warranty |
| :green_circle: Patent use     | :scroll: | |
| :green_circle: Private use    | :mute:   | |

See the [LICENSE.md](LICENSE.MD) file for full license. 

## Credits & Sponsors

- Seeds from the [Easybotics T3 rpi config script](https://github.com/easybotics/t3-rpi-config-script). 
- TODO: List of funders or partners sponsoring development

## Contributors

- [@dayne](https://github.com/dayne) - T3X Innovation  Architect
- [@ItalianSquirel](https://github.com/ItalianSquirel) - T3X Code Conjurer
- [@SushiFanta](https://github.com/SushiFanta) - T3X Algorithm Alchemist
