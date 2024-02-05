FROM debian:oldstable
RUN apt-get update && \
    apt-get install -y \
    dnsmasq \
    sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# カスタムDNS設定を環境変数に設定
ENV DNSMASQ_OPTS="--conf-file=/etc/dnsmasq.conf"

#ENTRYPOINT ["setup.sh"]
CMD ["dnsmasq", "-k"]