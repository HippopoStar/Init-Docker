# BYOTSS : Build Your Own TeamSpeak Server
# GNU Linux Magazine France - Hors-Serie 98 - Page 56 (EXPOSE)
# https://hub.docker.com/_/teamspeak/
# https://github.com/TeamSpeak-Systems/teamspeak-linux-docker-images/blob/master/alpine/
# https://www.teamspeak.com/en/downloads#server
# docker build --tag ex01_img ./
# docker run --name ex01_ctn -ti --rm ex01_img bash
# docker run --name ex01_ctn -p 9987:9987/udp -p 10011:10011 -p 30033:30033 -e TS3SERVER_LICENSE=accept --rm ex01_img
# docker rm ex01_ctn
# docker rmi ex01_img

FROM debian

RUN apt-get update && apt-get -y install curl bzip2

ARG TEAMSPEAK_URL=http://dl.4players.de/ts/releases/3.4.0/teamspeak3-server_linux_amd64-3.4.0.tar.bz2

RUN adduser teamspeak --disabled-password

WORKDIR /home/teamspeak/

RUN curl -o teamspeak3-server.tar.bz2 ${TEAMSPEAK_URL} \
	&& tar -xvjf teamspeak3-server.tar.bz2 --strip-components=1 \
	&& rm teamspeak3-server.tar.bz2

EXPOSE 9987/udp 10011 30033

USER teamspeak

ENTRYPOINT [ "/home/teamspeak/ts3server_minimal_runscript.sh license_accepted=1" ]
