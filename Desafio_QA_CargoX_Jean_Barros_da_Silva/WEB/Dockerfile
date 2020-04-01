FROM ruby:2.5.0-slim
MAINTAINER Jean

RUN mkdir /home/test

COPY Gemfile /home/test

WORKDIR /home/test

RUN apt-get update && \
apt-get install -y build-essential

RUN gem install bundler && \
bundle install --path vendor/cache
