FROM alpine:latest

LABEL "repository"="https://github.com/liri-infra/lupdate-action"
LABEL "homepage"="https://liri.io"
LABEL "maintainer"="Pier Luigi Fiorini <pierluigi.fiorini@liri.io>"

RUN set -ex && \
    apk add git openssh-client python3 py3-pip qt5-qttools qt5-qttools-dev itstool gettext intltool && \
    pip install transifex-client

ENV QT_SELECT=5
ENV PYTHONUNBUFFERED=1

# Otherwise we won't be able to write to GITHUB_WORKSPACE, see
# https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#docker-container-filesystem
USER root
WORKDIR /root
ENV HOME /root

RUN mkdir -p /usr/share/lupdate-action
COPY as-metainfo.its /usr/share/lupdate-action/as-metainfo.its
COPY entrypoint /entrypoint
COPY regenerate-sources /usr/bin/regenerate-sources

ENTRYPOINT ["/entrypoint"]
