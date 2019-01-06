FROM ubuntu:18.04

ENV DOTFILES /usr/local/src/dotfiles

ENV HOMEBREW_PREFIX /home/linuxbrew

ENV TZ=America/New_York

RUN echo "debconf debconf/frontend select Noninteractive" | debconf-set-selections

RUN apt-get update && \
      apt-get -y install apt-utils curl locales sudo && \
      locale-gen "en_US.UTF-8"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
      echo $TZ > /etc/timezone

RUN curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh > /tmp/install-linuxbrew.sh

RUN useradd --shell /bin/bash -u 1000 -o -c "" -m docker

RUN mkdir -p $HOMEBREW_PREFIX && \
      chown docker:docker $HOMEBREW_PREFIX

RUN su - docker -c "HOMEBREW_PREFIX=$HOMEBREW_PREFIX USER=docker sh /tmp/install-linuxbrew.sh"

COPY . $DOTFILES

RUN $DOTFILES/bin/setup-apt.sh

RUN su - docker -c "DOTFILES=$DOTFILES USER=docker $DOTFILES/bin/setup-homebrew.sh"

WORKDIR /home/docker

ENTRYPOINT [ "/usr/local/src/dotfiles/bin/docker-entrypoint.sh" ]
