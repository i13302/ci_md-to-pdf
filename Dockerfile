# https://kcpoipoi.hatenablog.com/entry/2020/07/27/120438#HTML%E5%87%BA%E5%8A%9B%E3%81%AE%E5%A0%B4%E5%90%88easy-pandoc-templates%E4%BD%BF%E7%94%A8%E3%82%92%E5%89%8D%E6%8F%90
FROM pandoc/latex:2.9.2.1
# FROM pandoc/latex:2.14.1


RUN tlmgr update --self && \
	tlmgr install \
      bxjscls \
      bxwareki \
      everyhook \
      ipaex \
      luatexja \
      svn-prov \
      type1cm \
	  
	  && \
    tlmgr update latex
RUN wget -O - https://github.com/lierdakil/pandoc-crossref/releases/download/v0.3.6.4/pandoc-crossref-Linux-2.9.2.1.tar.xz | \
  tar Jxf - \
  && mv pandoc-crossref /usr/lib/ \
  && rm -rf pandoc-crossref.1
RUN wget -O - https://github.com/ryangrose/easy-pandoc-templates/archive/master.tar.gz | \
  tar zxvf - -C /tmp/ \
  && mv /tmp/easy-pandoc-templates* /usr/lib/easy-pandoc-templates \
  && rm -rf /tmp/*


COPY . .
# ENTRYPOINT /usr/bin/pandoc
# ENTRYPOINT /bin/ash
