FROM ruby:latest

WORKDIR /neovim

RUN \
    apt-get update && \
    apt-get install -y \
      libtool \
      libtool-bin \
      autoconf \
      automake \
      cmake g++ \
      pkg-config \
      unzip && \
    git clone https://github.com/neovim/neovim.git && \
    cd neovim && \
    make install

RUN \
    git clone https://github.com/VundleVim/Vundle.vim.git \
      ~/.vim/bundle/Vundle.vim && \
    git clone https://github.com/chriskempson/base16-shell.git \
      ~/.config/base16-shell && \
    git clone https://github.com/scotthelm/nv.git ~/nv && \
    mkdir -p ~/.config/nvim && \
    cp ~/nv/init.vim ~/.config/nvim && \
    cp ~/nv/.bashrc ~/ && \
    cp ~/nv/.vimrc_background ~/ && \
    gem install bundler rubocop && \
    nvim +PluginInstall +qall
