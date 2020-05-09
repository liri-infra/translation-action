FROM opensuse/tumbleweed

RUN set -ex && \
    zypper install -y git openssh transifex-client itstool gettext-tools intltool libqt5-linguist

ENV QT_SELECT=5
ENV PYTHONUNBUFFERED=1

# Otherwise we won't be able to write to GITHUB_WORKSPACE, see
# https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#docker-container-filesystem
USER root
WORKDIR /root
ENV HOME /root

RUN mkdir -p /usr/share/translation-action
COPY as-metainfo.its /usr/share/translation-action/as-metainfo.its
COPY entrypoint /entrypoint
COPY regenerate-sources /usr/bin/regenerate-sources

ENTRYPOINT ["/entrypoint"]
