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
      ~/.vim/bundle/Vundle.vim

RUN gem install bundler rubocop

RUN mkdir -p ~/.config/nvim
COPY ./init.vim /root/.config/nvim

RUN \
    nvim +PluginInstall +qall
RUN \
    git clone https://github.com/chriskempson/base16-shell.git \
      ~/.config/base16-shell
COPY ./.bashrc /root
COPY ./.vimrc_background /root
