FROM jenkins/jenkins:2.365
COPY docker-archive-keyring.gpg /usr/share/keyrings/docker-archive-keyring.gpg 
USER root
RUN apt-get update \
    && apt-get install --no-install-recommends -y ca-certificates curl gnupg lsb-release git \
    && echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install --no-install-recommends -y docker-ce-cli
USER jenkins
ENTRYPOINT ["/usr/bin/tini", "--", "/usr/local/bin/jenkins.sh"]