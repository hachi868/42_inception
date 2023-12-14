FROM debian:oldstable
RUN apt-get update && \
    apt-get install -y \
    dnsmasq \
    sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 53 53/udp
#ENTRYPOINT ["dnsmasq", "-k"]
CMD ["/bin/bash"]
