#===================================================================================================
FROM alpine:3.6 as extracter
WORKDIR /tmp
RUN apk add -U unzip wget curl
#===================================================================================================

#===================================================================================================
# from Chromeの最新メジャーバージョンを元にChromeDriverの最新バージョンを取得するよう修正する by masaru-b-cl · Pull Request #16 · prismatix-jp/openjdk-with-git https://github.com/prismatix-jp/openjdk-with-git/pull/16/files
FROM extracter as unzipperchromedriver
RUN CHROME_LATEST_VERSION=$(curl -sS omahaproxy.appspot.com/linux?channel=beta) && \
	CHROME_LATEST_MAJOR_VERSION=$(echo $CHROME_LATEST_VERSION | cut -d . -f 1) && \
	CHROME_DRIVER_VERSION=$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_LATEST_MAJOR_VERSION) && \
	curl -sS http://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip -o chromedriver_linux64.zip && \
	unzip -q chromedriver_linux64.zip
#===================================================================================================

#===================================================================================================
FROM extracter as addsourcelist
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> google-chrome.list
#===================================================================================================

#===================================================================================================
# from 【Docker】 docker image の大きさを小さくする(その２) - Qiita https://qiita.com/XPT60/items/e123fe88ec88a4ac2749
FROM ubuntu:18.04 AS python-compile
WORKDIR /root

COPY src/requirements.txt .

RUN apt-get update && apt-get install -y python3 python3-pip
RUN python3 -m pip install --user -r requirements.txt
#===================================================================================================

#===================================================================================================
FROM python:3.8-buster
SHELL ["/bin/bash", "-c"]

WORKDIR /root

# add google-chrome apt list
COPY --from=addsourcelist /tmp/google-chrome.list /etc/apt/sources.list.d/google-chrome.list

RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# install any package
RUN apt-get -y update && \
	apt-get -y install --no-install-recommends python3-dev fonts-ipafont google-chrome-beta && \
	apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/*

COPY --from=python-compile /root/requirements.txt /root/requirements.txt
COPY --from=python-compile /root/.local /root/.local
COPY --from=python-compile /root/.cache /root/.cache

RUN pip3 install -r requirements.txt && \
    rm -rf requirements.txt /root/.local /root/.cache

COPY src/docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

# install ChromeDriver
COPY --from=unzipperchromedriver /tmp/chromedriver /usr/local/bin/chromedriver

COPY src/main.py .
ENTRYPOINT ["/root/docker-entrypoint.sh"]
#===================================================================================================
