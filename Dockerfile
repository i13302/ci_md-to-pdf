FROM alpine:3.6 as extracter
WORKDIR /tmp
RUN apk add -U unzip wget

FROM extracter as unzipperchromedriver
ARG CHROMEDRIVER_LINK=https://chromedriver.storage.googleapis.com/95.0.4638.17/chromedriver_linux64.zip
RUN	wget $CHROMEDRIVER_LINK -O chromedriver_linux64.zip --no-check-certificate && \
	unzip chromedriver_linux64.zip

FROM python:3.8-buster
SHELL ["/bin/bash", "-c"]

# add repository google-chrome
RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> /etc/apt/sources.list.d/google-chrome.list

# install any package
RUN apt-get -y update && \
	apt-get -y install python-dev default-libmysqlclient-dev google-chrome-beta=95.0.4638.40-1 && \
	apt-get -y autoremove && apt-get -y clean

# install ChromeDriver
WORKDIR /usr/local/bin
COPY --from=unzipperchromedriver /tmp/chromedriver .

WORKDIR /tmp
COPY requirements.txt .
RUN pip3 install --upgrade pip && pip3 install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /WORK
COPY . .
