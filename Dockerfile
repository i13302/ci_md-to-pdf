# https://kcpoipoi.hatenablog.com/entry/2020/07/27/120438#HTML%E5%87%BA%E5%8A%9B%E3%81%AE%E5%A0%B4%E5%90%88easy-pandoc-templates%E4%BD%BF%E7%94%A8%E3%82%92%E5%89%8D%E6%8F%90
# FROM pandoc/latex:2.9.2.1
FROM pandoc/latex:2.14.1

# コンテナのTimezoneをJSTにする (ログのタイムスタンプ用)
# http://kawaken.hateblo.jp/entry/2018/08/30/190954
RUN apk --no-cache add tzdata && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN apk add --update --no-cache \
    libgcc libstdc++ libx11 glib libxrender libxext libintl \
    ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family
COPY --from=madnight/alpine-wkhtmltopdf-builder:0.12.5-alpine3.10-606718795 \
    /bin/wkhtmltopdf /bin/wkhtmltopdf

RUN tlmgr update --self && \
	tlmgr install \
      bxjscls \
      bxwareki \
      everyhook \
      ipaex \
      luatexja \
      svn-prov \
      type1cm \
	  collection-latexextra \
      collection-fontsrecommended \
      collection-langjapanese \
	  && \
    tlmgr update latex

RUN apk update \
  && apk add --no-cache curl wget fontconfig \
  && curl -O https://noto-website.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip \
  && mkdir -p /usr/share/fonts/NotoSansCJKjp \
  && unzip NotoSansCJKjp-hinted.zip -d /usr/share/fonts/NotoSansCJKjp/ \
  && rm NotoSansCJKjp-hinted.zip \
  && fc-cache -fv

# RUN wget -O - https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.4/pandoc-crossref-Linux-2.9.2.1.tar.xz | \
#   tar Jxf - \
#   && mv pandoc-crossref /usr/lib/ \
#   && rm -rf pandoc-crossref.1
# RUN wget -O - https://github.com/ryangrose/easy-pandoc-templates/archive/master.tar.gz | \
#   tar zxvf - -C /tmp/ \
#   && mv /tmp/easy-pandoc-templates* /usr/lib/easy-pandoc-templates \
#   && rm -rf /tmp/*


COPY . .
# ENTRYPOINT /usr/bin/pandoc
# ENTRYPOINT /bin/ash
