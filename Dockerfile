FROM sonatype/nexus3:3.37.0

ARG NEXUS3_GITHUB_OAUTH_PLUGIN_VERSION=3.1.0

# Switch to a user who can install the plugin
USER root

# Install the github oauth plugin
RUN curl -s -L https://github.com/larscheid-schmitzhermes/nexus3-github-oauth-plugin/releases/download/$NEXUS3_GITHUB_OAUTH_PLUGIN_VERSION/nexus3-github-oauth-plugin.kar >/opt/sonatype/nexus/deploy/nexus3-github-oauth-plugin.kar

# Configure the github oauth plugin for our organisation
RUN echo -e "github.api.url=https://api.github.com\ngithub.principal.cache.ttl=PT1M\ngithub.org=cgi-eoss" >/opt/sonatype/nexus/etc/githuboauth.properties

# Re-enable script control
RUN echo -e "nexus.scripts.allowCreation=true" >>/opt/sonatype/nexus/etc/nexus.properties

# Switch back to the service user
USER nexus
