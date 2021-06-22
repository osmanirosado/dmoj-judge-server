FROM dmoj/runtimes-tier3

COPY pip.conf /etc/pip.conf

ARG TAG=master
RUN mkdir /judge /problems && cd /judge && \
	curl -L https://github.com/DMOJ/judge-server/archive/"${TAG}".tar.gz | tar -xz --strip-components=1 && \
	pip3 install -e . && \
	sed -i 's/\. "$HOME/. "\/home\/judge/' ~judge/.profile && \
	. ~judge/.profile && \
	runuser -u judge -w PATH -- dmoj-autoconf -V > /judge-runtime-paths.yml && \
	echo '  crt_x86_in_lib32: true' >> /judge-runtime-paths.yml

ENTRYPOINT ["/judge/.docker/entry"]
