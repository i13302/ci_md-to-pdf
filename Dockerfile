FROM alpine:3.6 as extracter
WORKDIR /tmp
RUN apk add -U unzip wget curl

FROM extracter as unzipperchromedriver
# from Chromeの最新メジャーバージョンを元にChromeDriverの最新バージョンを取得するよう修正する by masaru-b-cl · Pull Request #16 · prismatix-jp/openjdk-with-git https://github.com/prismatix-jp/openjdk-with-git/pull/16/files

RUN CHROME_LATEST_VERSION=$(curl -sS omahaproxy.appspot.com/linux?channel=beta) && \
	CHROME_LATEST_MAJOR_VERSION=$(echo $CHROME_LATEST_VERSION | cut -d . -f 1) && \
	CHROME_DRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_LATEST_MAJOR_VERSION) && \
	curl -sS http://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip -o chromedriver_linux64.zip && \
	unzip -q chromedriver_linux64.zip 
	
FROM extracter as addsourcelist
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> google-chrome.list

FROM python:3.8-buster
SHELL ["/bin/bash", "-c"]

WORKDIR /root
COPY src .

# install ChromeDriver
COPY --from=unzipperchromedriver /tmp/chromedriver /usr/local/bin/chromedriver

# add google-chrome apt list
COPY --from=addsourcelist /tmp/google-chrome.list /etc/apt/sources.list.d/google-chrome.list

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# install any package
RUN apt-get -y update && \
	apt-get -y install python3-dev fonts-ipafont google-chrome-beta && \
	apt-get -y autoremove && apt-get -y clean

RUN pip3 install --upgrade pip && pip3 install --no-cache-dir -r requirements.txt && \
    rm -f requirements.txt

RUN chmod +x docker-entrypoint.sh

ENTRYPOINT ["/root/docker-entrypoint.sh"]
