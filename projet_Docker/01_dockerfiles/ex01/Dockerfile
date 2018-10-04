# BYOTSS : Build Your Own TeamSpeak Server
# GNU Linux Magazine France - Hors-Serie 98 - Page 56 (EXPOSE)
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# https://hub.docker.com/_/teamspeak/
# https://github.com/TeamSpeak-Systems/teamspeak-linux-docker-images/blob/master/alpine/
# https://www.teamspeak.com/en/downloads#server

# docker build --tag ex01 ./
# docker run --name ex01 -p 9987:9987/udp -p 10011:10011 -p 30033:30033 --rm ex01

# docker rm ex01 (dans le cas '--rm' non active au lancement)
# docker rmi ex01

FROM debian

RUN apt-get update && apt-get -y install curl bzip2
RUN adduser teamspeak --disabled-password

ENV PATH "${PATH}:/home/teamspeak"
# Permet de verifier automatiquement la presence du script de demarrage dans le dossier '/home/teamspeak/' et par consequent de ne pas avoir a ajouter './' devant le nom du script dans la donne 'ENTRYPOINT'

ARG TEAMSPEAK_DIR=/home/teamspeak
ARG TEAMSPEAK_URL=http://dl.4players.de/ts/releases/3.4.0/teamspeak3-server_linux_amd64-3.4.0.tar.bz2

RUN curl -o ${TEAMSPEAK_DIR}/teamspeak3-server.tar.bz2 ${TEAMSPEAK_URL} \
	&& tar -xvjf ${TEAMSPEAK_DIR}/teamspeak3-server.tar.bz2 --strip-components=1 -C ${TEAMSPEAK_DIR} \
	&& rm ${TEAMSPEAK_DIR}/teamspeak3-server.tar.bz2

EXPOSE 9987/udp 10011 30033

USER teamspeak
WORKDIR ${TEAMSPEAK_DIR}
# Pour atterir dans le dossier '/home/teamspeak/' dans le cas 'docker run [...] ex01 bash'

ENTRYPOINT [ "ts3server_minimal_runscript.sh" , "license_accepted=1" ]
