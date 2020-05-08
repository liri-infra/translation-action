FROM ubuntu:18.04

LABEL "repository"="https://github.com/liri-infra/lupdate-action"
LABEL "homepage"="https://liri.io"
LABEL "maintainer"="Pier Luigi Fiorini <pierluigi.fiorini@liri.io>"

RUN set -ex && \
    apt-get update -y && \
    apt-get install -y curl gnupg2 software-properties-common && \
    curl 'http://archive.neon.kde.org/public.key' | apt-key add - && \
    apt-add-repository http://archive.neon.kde.org/user && \
    apt-get update -y && \
    apt-get install -y python3 git qttools5-dev-tools itstool

ENV QT_SELECT=5

# Otherwise we won't be able to write to GITHUB_WORKSPACE, see
# https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#docker-container-filesystem
USER root
WORKDIR /root
ENV HOME /root

RUN mkdir -p /usr/share/lupdate-action
COPY as-metainfo.its /usr/share/lupdate-action/as-metainfo.its
COPY entrypoint /entrypoint
COPY translate-desktop /usr/bin/translate-desktop

ENTRYPOINT ["/entrypoint"]
