FROM pandoc/latex:2.14.1

WORKDIR /data

RUN apk add --update ghostscript && \
	tlmgr update --self && \
	tlmgr install collection-langjapanese luatexja selnolig bxjscls && \
	apk del tzdata && \
	rm -rf /opt/texlive/texdir/tlpkg/backups /opt/texlive/texdir/texmf-var/web2c/*.log

RUN apk add --update --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family

COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10-606718795 \
    /bin/wkhtmltopdf /bin/wkhtmltopdf


RUN apk update \
  && apk add --no-cache curl wget fontconfig \
  && curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
  && mkdir -p /usr/share/fonts/NotoSansCJKjp \
  && unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ \
  && rm NotoSansCJKjp-hinted.zip \
  && fc-cache -fv

COPY . .

# ENTRYPOINT /bin/ash
