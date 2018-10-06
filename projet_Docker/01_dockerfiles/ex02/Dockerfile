# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# https://guides.rubyonrails.org/getting_started.html
# https://hub.docker.com/_/rails/

# docker build --tag ft_rails:on-build ./
# docker run --name ex02 -ti -p 3000 --rm ft_rails:on-build bash

FROM ruby

RUN apt-get update && apt-get -y install mysql-client

WORKDIR /opt/app
COPY Gemfile* ./
RUN bundle install
COPY . ./

EXPOSE 3000
CMD [ "rails" , "server" , "-b" , "0.0.0.0" , "-p" , "3000" ]
