FROM debian:12-slim

COPY sources.list /etc/apt/
RUN apt-get update && apt-get install -y inotify-tools && apt-get clean
