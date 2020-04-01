FROM ruby:2.5.0-slim
MAINTAINER Jean

COPY Gemfile /var/www

WORKDIR /var/www

RUN apt-get update && \
apt-get install -y build-essential

RUN gem install bundler

ENTRYPOINT bundle install
