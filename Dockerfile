FROM pandoc/latex:2.14.1

RUN apk add --update ghostscript && \
	tlmgr update --self && \
	apk del tzdata
COPY . .
