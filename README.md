# Dotfiles ~/.*

My dot files shared between machines for Bash, Linux, and OSX.

## Installing

``` bash
git clone --recursive https://github.com/chiayolin/dotfiles 
```
Pass `--recursive` to `git clone` so it will clone the project with submodule(s). 

Run `install-dotfiles.sh` to install dot files. Or copy these to ~/ one by one.

Here's a quick way to install it, just paste that at a terminal prompt.

```bash
git clone --recursive https://github.com/chiayolin/dotfiles ~/dotfiles && sh ~/dotfiles/install-dotfiles.sh && source ~/.bash_profile
```

## Contact

[Chiayo Lin](mailto:chiayo.lin@gmail.com)

## License

These dot files are licensed under the [MIT License](http://en.wikipedia.org/wiki/MIT_License).
The full license text is available in [LICENSE.txt](https://raw.githubusercontent.com/chiayolin/dotfiles/master/LICENSE.txt).
