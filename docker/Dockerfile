FROM jenkins/jenkins:lts-jdk17
USER root
RUN apt-get update && apt-get install -y git rsync curl
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt
COPY casc/ /var/jenkins_home/casc_configs/
ENV CASC_JENKINS_CONFIG=/var/jenkins_home/casc_configs
USER jenkins