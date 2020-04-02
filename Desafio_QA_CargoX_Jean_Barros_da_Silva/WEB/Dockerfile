FROM ruby:2.4-slim
MAINTAINER Jean

RUN apt-get update && \
apt-get install -y build-essential

RUN mkdir /home/test

WORKDIR /home/test

USER 1000:1000

# RUN groupadd jenkins -g 1000

# RUN useradd -u 1000 -g 1000 -s /bin/sh jenkins

COPY Gemfile /home/test

RUN gem install bundler && \
bundle install
