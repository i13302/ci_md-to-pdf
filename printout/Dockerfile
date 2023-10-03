#===================================================================================================
FROM alpine:3.6 as extracter
WORKDIR /tmp
RUN apk add -U unzip curl
#===================================================================================================

#===================================================================================================
# https://blog.shikoan.com/chrome-drive-binary/
# https://zenn.dev/route06/articles/78c30c6627a932
FROM extracter as unzipperchromedriver
RUN CHROMEDRIVER_VERSION=$(curl -sS https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_STABLE) && \
	curl -sS https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/$CHROMEDRIVER_VERSION/linux64/chromedriver-linux64.zip && \
	unzip -q chromedriver_linux64.zip
#===================================================================================================

#===================================================================================================
FROM extracter as addsourcelist
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' >> google-chrome.list
#===================================================================================================

#===================================================================================================
FROM extracter as downloadchrome
RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
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
COPY --from=unzipperchromedriver /tmp/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver

# add google-chrome
COPY --from=downloadchrome /tmp/google-chrome-stable_current_amd64.deb /tmp/google-chrome-stable_current_amd64.deb 

# install any package
RUN apt-get -y update && \
	apt-get -y install --no-install-recommends fonts-ipafont /tmp/google-chrome-stable_current_amd64.deb && \
	apt-get -y autoremove && apt-get -y clean && rm -rf /var/lib/apt/lists/* && rm /tmp/google-chrome-stable_current_amd64.deb 

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
