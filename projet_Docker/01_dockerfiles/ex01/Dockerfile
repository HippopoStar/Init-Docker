# BYOTSS : Build Your Own TeamSpeak Server
# GNU Linux Magazine France - Hors-Serie 98 - Page 56 (EXPOSE)
# https://hub.docker.com/_/teamspeak/
# https://github.com/TeamSpeak-Systems/teamspeak-linux-docker-images/blob/master/alpine/Dockerfile
# https://www.teamspeak.com/en/downloads#server
# docker build --tag ex01_img ./
# docker run --name ex01_ctn -ti --rm ex01_img bash
# docker run --name ex01_ctn -p 9987:9987/udp -p 10011:10011 -p 30033:30033 -e TS3SERVER_LICENSE=accept --rm ex01_img
# docker rm ex01_ctn
# docker rmi ex01_img

FROM debian

ARG TEAMSPEAK_URL=http://dl.4players.de/ts/releases/3.4.0/teamspeak3-server_linux_amd64-3.4.0.tar.bz2

RUN apt-get update \
	&& apt-get -y install curl \
	&& apt-get -y install bzip2 \
	&& mkdir -p /root/ts3server/ \
	&& curl -o /root/ts3server/teamspeak3-server.tar.bz2 ${TEAMSPEAK_URL} \
	&& tar -xvjf /root/ts3server/teamspeak3-server.tar.bz2 --strip-components=1 -C /root/ts3server/ \
	&& rm -f /root/ts3server/teamspeak3-server.tar.bz2 \
	&& mv /root/ts3server/*.so /root/ts3server/redist/* /usr/local/lib/ \
	&& ldconfig /usr/local/lib/

EXPOSE 9987/udp 10011 30033

CMD [ "/root/ts3server/ts3server" ]
