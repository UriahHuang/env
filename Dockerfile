FROM tensorflow/tensorflow:1.7.0-devel-py3
# tags like:
#   1.7.0-devel-gpu-py3
#   1.7.0-devel-py3
EXPOSE 8888 8887 8886

### create user jason
RUN useradd --create-home --shell /bin/bash jason

### usefule tools
RUN apt-get update && apt-get install -y \
git wget tmux vim build-essential cmake
# may need python-dev python3-dev for installing youcompleteme, 1.7.0-rc1-devel-py3 already has

### python packages to install
RUN pip install --upgrade pip && \
pip install gym flake8

### pretty vim
#COPY ~/.vimrc ~
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && \
sh ~/.vim_runtime/install_awesome_vimrc.sh

### pretty tmux
RUN git clone https://github.com/gpakosz/.tmux.git ~/.tmux && \
cp ~/.tmux/.tmux.conf .
RUN echo "export TERM=xterm-256color" >> ~/.bashrc && \
echo "export EDITOR=vim" >> ~/.bashrc

### install Vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# prepare .vundle_vimrc yourself
COPY vundle_vimrc .
RUN echo "$(cat ~/vundle_vimrc)\n$(cat ~/.vimrc)" > ~/.vimrc

### other installation inside container
RUN vim -c 'PluginInstall' -c 'qa!'
# install Valloric/YouCompleteMe with vundle, then
#   cd ~/.vim/bundle/YouCompleteMe && ./install.py
RUN cd ~/.vim/bundle/YouCompleteMe && ./install.py && cd -
# install vim-syntastic/syntastic with vundle, use flake8 for python checker with args
#   execute pathogen#infect()
#   let g:syntastic_python_checkers = ['flake8']
#   let g:syntastic_python_flake8_args = '--ignore W,E'
RUN echo "let g:ale_emit_conflict_warnings = 0" >> ~/.vimrc && \
echo "execute pathogen#infect()\n" >> ~/.vimrc

### git utilities
# pretty git graph plot
RUN echo "[user]" >> ~/.gitconfig && \
echo "email = jasonhuang432@gmail.com" >> ~/.gitconfig && \
echo "name = jason" >> ~/.gitconfig
RUN echo "[alias]" >> ~/.gitconfig && \
echo "lg = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)' --all" >> ~/.gitconfig && \
echo "lg2 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all" >> ~/.gitconfig && \
echo "lg3 = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)' --all" >> ~/.gitconfig
# bash show git branch, add to .bashrc
#    parse_git_branch() {
#      git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
#    }
#   \[\033[01;31m\]$(parse_git_branch)

### tmux utility
# make tmux color when launch session
#   case "$TERM" in
#       xterm-color|*-256color) color_prompt=yes;;
#   esac

### bash utilities
# history search with prefix
RUN echo "\e[A":history-search-backward >> ~/.inputrc && \
echo "\e[B":history-search-forward >> ~/.inputrc

### copy setting to jason
RUN cp -r /root/. /home/jason && \
chown -R jason /home/jason

### switch user inside container
# su jason && cd

### other notes
# if you need default user to be jason, use this
# better figure out how to grant jason root permisssion
#USER jason
#WORKDIR /home/jason

CMD ["/bin/bash"]

