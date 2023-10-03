#===================================================================================================
FROM alpine:3.6 as extracter
WORKDIR /tmp
RUN apk add -U unzip curl
#===================================================================================================

#===================================================================================================
# from Chromeの最新メジャーバージョンを元にChromeDriverの最新バージョンを取得するよう修正する by masaru-b-cl · Pull Request #16 · prismatix-jp/openjdk-with-git https://github.com/prismatix-jp/openjdk-with-git/pull/16/files
FROM extracter as unzipperchromedriver
RUN curl -O https://chromedriver.storage.googleapis.com/$(curl -s https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip && \
    unzip -q chromedriver_linux64.zip
#===================================================================================================

#===================================================================================================
FROM extracter as addsourcelist
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> google-chrome.list
#===================================================================================================

#===================================================================================================
# from 【Docker】 docker image の大きさを小さくする(その２) - Qiita https://qiita.com/XPT60/items/e123fe88ec88a4ac2749
FROM debian:buster AS python-compile
WORKDIR /root

COPY requirements.txt .

RUN apt-get -y update && apt-get -y install python3 python3-pip
RUN pip3 install --user -r requirements.txt
#===================================================================================================

#===================================================================================================
FROM python:3.8-buster
SHELL ["/bin/bash", "-c"]

WORKDIR /root

# install ChromeDriver
COPY --from=unzipperchromedriver /tmp/chromedriver /usr/local/bin/chromedriver

# add google-chrome apt list
COPY --from=addsourcelist /tmp/google-chrome.list /etc/apt/sources.list.d/google-chrome.list
RUN curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

# install any package
RUN apt-get -y update && \
	apt-get -y install --no-install-recommends fonts-ipafont google-chrome-beta && \
	apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/*

COPY --from=python-compile /root/requirements.txt /root/requirements.txt
COPY --from=python-compile /root/.local /root/.local
COPY --from=python-compile /root/.cache /root/.cache
RUN pip3 install -r requirements.txt && \
    rm -rf requirements.txt /root/.local /root/.cache

COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh

COPY main.py .

WORKDIR /data
ENTRYPOINT ["/root/docker-entrypoint.sh"]
#===================================================================================================
