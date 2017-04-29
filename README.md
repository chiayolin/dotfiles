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
$ git clone --recursive https://github.com/chiayolin/dotfiles.git $HOME/Dotfiles/
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

## Rundown

This repository is structured as the directory tree shown below:

```sh
.
├── formulae        # the dotfiles are stored here
│   ├── _include    # shared configuation files
│   │   └── _bin    # script(s) that the dotfiles will run
│   └── ...         # the configuation files/directories
└── packages        # rules for installing packages
    └── ...         # dirs containing rules for each package
```

### `formulae/`
The directory `formulae/` contains the dotfiles. Therefore, every file inside 
this directory will be symlinked to `$HOME` after the process of installation 
is completed (after running `sh strap.sh install`). The symlinks inside 
`$HOME` are _dotfiles_ with their original file extensions removed:

```sh
formulae/zshrc.sh -> $HOME/.zshrc
```

The shared configuation files are stored under `_formulae/_include`. Take a 
look at this directory to get an idea of what kind of files would belong to
here. Futhermore, scripts or binary used by the dotfiles are placed under
`_formulae/_include/_bin`. 

### `packages/`

This diectory is consisted of subdirectories containing installation scripts
for each supported operating system. The defined packages under `packages/`
can be installed by running `strap.sh install-pkg`. However, _this feature is 
still under development_, so only macOS is currently supported.

Each subdirectory of `packages/` is named using the name of a specific package and 
contains a couple of files, that among them are, a file with `.info` as its file
extension and files that contains rules for installing this package on differnet 
operating system. The tree shown below is an exmaple of a subdirectory containing
rules for installing `archey`:

```sh
archey
├── archey.darwin
├── archey.ubuntu
├── ...
└── archey.info
```

When `strap.sh install-pkg` is executed, `strap.sh` will look into every
subdirectory inside `packages/` for a file ends with `.info` and run it.
`strap.sh` will proceed to determine the current operating system running on 
the machine. And based upon the result, for instance, `strap.sh` will look for 
`archey.darwin` if the machine is running macOS or `archey.ubuntu` if the
operating system is Ubuntu and etc. Every file under each subdirectory is just
a regular shell script that automates the process of installing a package.

## Author

[![Chiayo Lin](https://img.shields.io/badge/author-Chiayo%20Lin-green.svg)](mailto:chiayo.lin@gmail.com)

Any patches or pull-requests are more than welcome :)

## License
[![GitHub license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://raw.githubusercontent.com/chiayolin/dotfiles/master/LICENSE.txt)
> "The code is dedicated, in respect and admiration, to the spirit that lives in
   the computer" ~ Alan J. Perlis. _Structure and Interpretation of 
  Computer Programs_, pp. foreword.
