# Vimfiles

## Installation

Clone this repo:

```bash
$ git clone https://github.com/vdmgolub/vimfiles.git ~/.vim
```

Symlink vimrc to home directory:

```bash
$ ln -s ~/.vim/vimrc ~/.vimrc
```

Install [Neobundle](https://github.com/Shougo/neobundle.vim)

```bash
$ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
```

Download and install font from [here](https://github.com/powerline/fonts/tree/master/InconsolataDz).
It is patched to show special characters.

Running command to install all plugins:

```bash
$ vim +NeoBundleInstall +qall
```

Enjoy :)
