FROM ruby:2.7-slim
MAINTAINER Jean

RUN apt-get update && \
apt-get install -y build-essential && \
apt-get install -y unzip xvfb libxi6 libgconf-2-4 && \
apt-get install -y curl && \
curl -sS -o - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add && \
echo "deb [arch=amd64]  http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list && \
apt-get -y update && \
apt-get -y install google-chrome-stable && \
wget https://chromedriver.storage.googleapis.com/2.41/chromedriver_linux64.zip && \
unzip chromedriver_linux64.zip && \
mv chromedriver /usr/bin/chromedriver && \
chown root:root /usr/bin/chromedriver && \
chmod +x /usr/bin/chromedriver

RUN mkdir /home/test

WORKDIR /home/test

COPY Gemfile /home/test

RUN gem install bundler && \
bundle install