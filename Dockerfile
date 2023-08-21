FROM kdeorg/suse-qt65

ENV QT_SELECT=6
ENV PYTHONUNBUFFERED=1

# Otherwise we won't be able to write to GITHUB_WORKSPACE, see
# https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners#docker-container-filesystem
USER root
WORKDIR /root
ENV HOME /root

# Install Transifex and other tools
RUN zypper --non-interactive install \
        curl python310-pip itstool && \
    pip install GitPython polib && \
    curl -o- https://raw.githubusercontent.com/transifex/cli/master/install.sh | bash && \
    mv tx /usr/bin

RUN mkdir -p /usr/share/translation-action
COPY as-metainfo.its /usr/share/translation-action/as-metainfo.its
COPY entrypoint /entrypoint
COPY regenerate-sources /usr/bin/regenerate-sources
COPY desktop-to-pot /usr/bin/desktop-to-pot
COPY desktop-merge /usr/bin/desktop-merge

ENTRYPOINT ["/entrypoint"]
