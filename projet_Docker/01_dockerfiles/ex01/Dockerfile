# GNU Linux Magazine France - Hors-Serie 98 - Page 56 (EXPOSE)
# https://www.teamspeak.com/en/downloads#server
# docker build --tag ex01_img ./
# docker run --name ex01_ctn -ti --rm ex01_img bash
# docker rm ex01_ctn
# docker rmi ex01_img

FROM debian

RUN apt-get update \
	&& apt-get -y install curl \
	&& apt-get -y install bzip2 \
	&& curl -o teamspeak3-server.tar.bz2 http://dl.4players.de/ts/releases/3.4.0/teamspeak3-server_linux_amd64-3.4.0.tar.bz2 \
	&& tar -xvjf teamspeak3-server.tar.bz2
