FROM sonatype/nexus3:3.14.0

# Switch to a user who can install the plugin
USER root

# Install the github oauth plugin
RUN yum install -y unzip && yum clean all &&\
 mkdir -p /opt/sonatype/nexus/system/com/larscheidschmitzhermes/ &&\
 curl -s -L https://github.com/larscheid-schmitzhermes/nexus3-github-oauth-plugin/releases/download/2.0.1/nexus3-github-oauth-plugin.zip >/tmp/nexus3-github-oauth-plugin.zip &&\
 unzip /tmp/nexus3-github-oauth-plugin.zip -d /opt/sonatype/nexus/system/com/larscheidschmitzhermes/ &&\
 echo "mvn\:com.larscheidschmitzhermes/nexus3-github-oauth-plugin/2.0.1 = 200" >>/opt/sonatype/nexus/etc/karaf/startup.properties

# Configure the github oauth plugin for our organisation
RUN echo -e "github.api.url=https://api.github.com\ngithub.principal.cache.ttl=PT1M\ngithub.org=cgi-eoss" >/opt/sonatype/nexus/etc/githuboauth.properties

# Switch back to the service user
USER nexus
