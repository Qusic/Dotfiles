#!/bin/sh
set -euo pipefail

link() {
  src=$(dirname $0)/$1
  dst=~/$2
  mkdir -pv $(dirname $dst)
  ln -sfnv $src $dst
}

link zshrc .zshrc
link tmux.conf .tmux.conf
link nvim.vim .config/nvim/init.vim
link gitconfig .gitconfig

curl -Lo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +'PlugUpdate' +qa
nvim +'PromptlineSnapshot! ~/.zshui' +'TmuxlineSnapshot! ~/.tmuxui.conf' +qa
