FROM debian:buster
ENV DEBIAN_FRONTEND noninteractive

ADD sources-buster.list /etc/apt/sources.list.d/
RUN apt update && apt --no-install-recommends install zsh devscripts -y 

ADD netscout.zsh /srv/

WORKDIR /srv/

CMD zsh netscout.zsh
