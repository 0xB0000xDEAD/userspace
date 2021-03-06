FROM alpine:latest
LABEL maintainer "0xB0000xDEAD  <12735140+0xB0000xDEAD@users.noreply.github.com>"
LABEL org.opencontainers.image.source https://github.com/<owner>/<userSpaceRepoName>

ARG user=johndoe
ARG group=wheel
ARG uid=1000
ARG dotfiles=dotfiles.git
ARG userspace=userspace.git
ARG vcsprovider=github.com
ARG vcsowner=0xB0000xDEAD

USER root


RUN \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk upgrade --no-cache && \
    apk add --update --no-cache \
    sudo \
    autoconf \
    automake \
    libtool \
    ncurses \
    ca-certificates \
    libressl \
    bash-completion \
    cmake \
    ctags \
    file \
    curl \
    build-base \
    gcc \
    coreutils \
    wget \
    neovim \
    git git-doc \
    zsh \
    docker \
    docker-compose \
    tmux \
    jq \
    bat \
    neofetch



RUN \
    echo "%${group} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    adduser -D -G ${group} ${user} && \
    addgroup ${user} docker

COPY ./ /home/${user}/.userspace/

# RUN \
#     git clone --recursive https://${vcsprovider}/${vcsowner}/${dotfiles} /home/${user}/.dotfiles && \
#     chown -R ${user}:${group} /home/${user}/.dotfiles && \
#     chown -R ${user}:${group} /home/${user}/.userspace
# # For advanced configuration where you would do ssh-agent and gpg-agent passthrough
# # cd /home/${user}/.userspace && \
# # git remote set-url origin git@${vcsprovider}:${vcsowner}/${userspace} && \
# # cd /home/${user}/.dotfiles && \
# # git remote set-url origin git@${vcsprovider}:${vcsowner}/${dotfiles}

USER ${user}
# RUN \
#     cd $HOME/.dotfiles && \
#     ./install-profile default


# RUN \
#     cd $HOME/.dotfiles && \
#     ./install-profile default && \
#     cd $HOME/.userspace && \
#     ./install-standalone \
#     zsh-dependencies \
#     zsh-plugins \
#     vim-dependencies \
#     vim-plugins \
#     tmux-plugins

RUN \ 
    if [ ! -d ~/.fzf ]; then git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; fi && ~/.fzf/install --key-bindings --completion --no-update-rc 

ENV HISTFILE=/config/.history


CMD []