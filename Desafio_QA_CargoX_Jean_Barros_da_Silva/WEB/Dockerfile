FROM ruby:2.4-slim
MAINTAINER Jean

RUN apt-get update && \
apt-get install -y build-essential

RUN mkdir /home/test

WORKDIR /home/test

COPY . /home/test

RUN gem install bundler && \
bundle install

ENTRYPOINT "bin/bash"
