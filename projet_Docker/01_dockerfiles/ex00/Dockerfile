# GNU Linux Magazine France - Hors Serie 98 - Pages 51 (--rm), 55
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

# docker build --tag ex00 ./
# docker run --name ex00_ctn -ti --rm ex00

# docker rm ex00 (dans le cas '--rm' non active au lancement)
# docker rmi ex00

# docker-machine ssh Char env
# docker-machine ssh Char sudo ls /var/lib/docker/

FROM alpine

RUN apk update && apk add vim

CMD vim
