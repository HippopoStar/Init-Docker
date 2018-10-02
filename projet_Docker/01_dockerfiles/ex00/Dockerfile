# GNU Linux Magazine France - Hors Serie 98 - Pages 51 (--rm), 55
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# docker build --tag ex00_img ./
# docker run --name ex00_ctn -ti --rm ex00_img
# docker rm ex00_ctn (dans le cas '--rm' non active au lancement)
# docker rmi ex00_img
# docker-machine ssh Char env
# docker-machine ssh Char sudo ls /var/lib/docker/

FROM alpine

RUN apk update && apk add vim

CMD vim
