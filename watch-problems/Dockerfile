FROM ubuntu:focal

COPY sources.list /etc/apt/
RUN apt-get update && apt-get install -y inotify-tools && apt-get clean
