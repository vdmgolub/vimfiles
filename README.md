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

Create `pack/minpac/opt/` directory in `.vim/` and install
[minpac](https://github.com/k-takata/minpac):

```bash
$ git clone https://github.com/k-takata/minpac.git ~/.vim/pack/minpac/opt/minpac
```

Download and install font from [here](https://github.com/powerline/fonts/tree/master/InconsolataDz).
It is patched to show special characters.

Open vim and run the following command to install/update all plugins:

```bash
:call minpac#update()
```

Enjoy :)
