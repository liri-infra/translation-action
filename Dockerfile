FROM a12e/docker-qt:5.14-gcc_64

LABEL "repository"="https://github.com/liri-infra/lupdate-action"
LABEL "homepage"="https://liri.io"
LABEL "maintainer"="Pier Luigi Fiorini <pierluigi.fiorini@liri.io>"

# Otherwise we won't be able to write to GITHUB_WORKSPACE, see
# https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#docker-container-filesystem
USER root
WORKDIR /root
ENV HOME /root

RUN set -ex && \
    apt install -y python3 git

ADD entrypoint /entrypoint
ADD translate-desktop /usr/bin/translate-desktop

ENTRYPOINT ["/entrypoint"]
