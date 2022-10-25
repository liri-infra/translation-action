FROM kdeorg/ci-suse-qt515

ENV QT_SELECT=5
ENV PYTHONUNBUFFERED=1

# Otherwise we won't be able to write to GITHUB_WORKSPACE, see
# https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#docker-container-filesystem
USER root
WORKDIR /root
ENV HOME /root

# Install stuff for Transifex and stuff
RUN zypper --non-interactive install \
        python3-pip itstool libqt5-linguist && \
    pip install GitPython polib transifex-client>=0.14

RUN mkdir -p /usr/share/translation-action
COPY as-metainfo.its /usr/share/translation-action/as-metainfo.its
COPY entrypoint /entrypoint
COPY regenerate-sources /usr/bin/regenerate-sources
COPY desktop-to-pot /usr/bin/desktop-to-pot
COPY desktop-merge /usr/bin/desktop-merge

ENTRYPOINT ["/entrypoint"]
