# Vimfiles (for Neovim)

## Installation

Clone this repo:

```bash
$ git clone https://github.com/vdmgolub/vimfiles.git ~/.config/nvim/
```

Install [Plug](https://github.com/junegunn/vim-plug) plugin manager:
```
curl -fLo ~/.config/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Download and install font from [here](https://github.com/powerline/fonts/tree/master/InconsolataDz).
It is patched to show special characters.

Open nvim and run the following command to install/update all plugins:

```bash
:PlugInstall
```

Enjoy :)
