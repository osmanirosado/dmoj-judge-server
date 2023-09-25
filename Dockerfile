ARG BASE_IMAGE

FROM ${BASE_IMAGE:-dmoj/judge-tier3:latest}

RUN echo 'problem_storage_root: [ "/problems" ]' > /judge.yml && cat /judge-runtime-paths.yml >> /judge.yml
