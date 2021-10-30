FROM pandoc/latex

COPY docker-entrypoint.sh /root/docker-entrypoint.sh

RUN chmod +x /root/docker-entrypoint.sh

ENTRYPOINT ["/root/docker-entrypoint.sh"]
