FROM dmoj/runtimes-tier3

COPY install-judge.sh /home
RUN bash /home/install-judge.sh

ENTRYPOINT ["/judge/.docker/entry"]
