# Chiayo's ~/.\*

![a screenshot of my shell](http://i.imgur.com/RsWMhK0.png?1)

## Installation

**Warning:** If you somehow want to give these dotfiles a try, please review
the code and edit or remove things that you don't want or need (e.g. `gitconfig`),
pronto! By running `strap.sh install`, some of the existing dotfiles on your 
machine may be removed and replaced with the symlinks to the dotfiles provided by 
this repository. _Use and install these dotfiles at your own risk_.

Clone the repository to wherever you want. The below example keeps the repositry
in `$HOME/Dotfiles/` (the uppercase 'D' in 'Dotfiles' gives the home directory
a more consistent look since most of the stock folders start with uppercase
letters):

```sh
$ git clone https://github.com/chiayolin/dotfiles.git $HOME/Dotfiles/
```

Initialise the repository with its submodules (e.g. plugins for
shell and vim), and get everythng up to date by running 
`strap.sh update`:

```sh
$ sh strap.sh update # pulling updates from upstream
```

To install the dotfiles, run `sh strap.sh install`:

```sh
$ sh strap.sh install
```

Alternatively, update and install the dotfiles in one step:

```sh
$ sh strap.sh update && sh strap.sh install
```

Execute `strap.sh` with no argument for help and usage:

```sh
$ sh strap.sh
```
## Directory Rundown

```sh
.
├── formulae        # the dotfiles are stored here
│   ├── _include    # shared shell configuation files
│   │   └── _bin    # script(s) that the dotfiles will run
│   ├── kwm         # config files for kwm window manager
│   ├── vim         # config files for vim text editor 
│   └── zsh         # config files for zsh shell
└── packages        # rules for installing each package
    ├── archey      # script(s) for installing arhcey 
    ├── hfile       # script(s) for installing hfile
    ├── htop        # script(s) for installing htop
    ├── iterm2      # script(s) for installing iterm2
    │   └── config  # contains iterm2's config
    ├── nbc         # script(s) for installing nbc
    ├── tmux        # script(s) for installing tmux
    └── vim         # script(s) for installing vim
```

## Author

[![Chiayo Lin](https://img.shields.io/badge/author-Chiayo%20Lin-green.svg)](mailto:chiayo.lin@gmail.com)

Any patches and pull-requests are more than welcome :)

## License
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://raw.githubusercontent.com/chiayolin/dotfiles/master/LICENSE.txt)
> "The code is dedicated, in respect and admiration, to the spirit that lives in
   the computer" ~ Alan J. Perlis. _Structure and Interpretation of 
  Computer Programs_, pp. foreword.
