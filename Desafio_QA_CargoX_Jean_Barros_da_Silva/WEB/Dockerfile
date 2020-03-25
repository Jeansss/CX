FROM ruby:2.5.0-slim
MAINTAINER Jean

RUN mkdir /home/test

COPY . /home/test
WORKDIR /home/test

RUN apt-get update && \
apt-get install -y build-essential && \
apt-get install -y wget && \
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
apt-get install -y ./google-chrome-stable_current_amd64.deb

RUN apt-get install -y unzip

RUN set -ex \
    && wget -Nv http://chromedriver.storage.googleapis.com/2.39/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && chmod -v +x chromedriver \
    && mv -v chromedriver /usr/local/bin/ \
    && rm -v chromedriver_linux64.zip

RUN gem instal bundler && \
bundle