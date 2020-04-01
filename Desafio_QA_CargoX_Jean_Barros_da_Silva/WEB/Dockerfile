FROM ruby:2.5.0-slim
MAINTAINER Jean

COPY Gemfile /home/test

WORKDIR /home/test

RUN apt-get update && \
apt-get install -y build-essential

RUN gem install bundler && \
bundle
