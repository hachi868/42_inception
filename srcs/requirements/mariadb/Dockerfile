FROM debian:oldstable

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    # キャッシュのクリーンアップ
    apt-get clean && \
    # 一時ファイル削除
    rm -rf /var/lib/apt/lists/*

COPY ./tools/setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup.sh

ENTRYPOINT ["/usr/local/bin/setup.sh"]

# MariaDBサーバーを実行
CMD ["mysqld"]