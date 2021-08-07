FROM dmoj/runtimes-tier3:latest

COPY pip.conf /etc/pip.conf

ARG TAG=master
RUN mkdir /judge /problems && cd /judge && \
	curl -L http://nexus.uclv.edu.cu/repository/github.com/DMOJ/judge-server/archive/"${TAG}".tar.gz | tar -xz --strip-components=1 && \
	pip3 install -e . && \
	sed -i 's/\. "$HOME/. "\/home\/judge/' ~judge/.profile && \
	. ~judge/.profile && \
	runuser -u judge -w PATH -- dmoj-autoconf -V > /judge-runtime-paths.yml && \
	echo '  crt_x86_in_lib32: true' >> /judge-runtime-paths.yml && \
    mkdir /mnt/config /mnt/problems && \
    echo 'problem_storage_root: [ "/mnt/problems" ]' > /mnt/config/judge.yml && \
    cat /judge-runtime-paths.yml >> /mnt/config/judge.yml

ENTRYPOINT ["/judge/.docker/entry"]
