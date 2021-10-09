# https://44smkn.hatenadiary.com/entry/2021/03/23/224925
# FROM ubuntu:focal

# ENV TZ=Asia/Tokyo
# RUN apt-get update && apt-get install -y tzdata
# RUN apt-get install -y pandoc wkhtmltopdf fonts-ipafont fonts-ipaexfont && \
#     fc-cache -fv && \
# 	apt-get autoremove && apt-get clean

# LABEL org.opencontainers.image.source=https://github.com/44smkn/pandoc-ja-container

# ENTRYPOINT [ "pandoc" ]
FROM ghcr.io/44smkn/pandoc/ja:0.1.1
# WORKDIR /data
COPY . .
# ENTRYPOINT [ "/bin/bash" ]
