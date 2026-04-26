FROM jenkins/jenkins:lts-jdk17

USER root
RUN apt-get update && apt-get install -y \
    git \
    rsync \
    curl \
    jq \
    yq \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Plugins baseline
COPY docker/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# ✅ Correct JCasC location (read on first startup)
COPY casc/ /usr/share/jenkins/ref/casc_configs/

ENV CASC_JENKINS_CONFIG=/usr/share/jenkins/ref/casc_configs
ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false

USER jenkins