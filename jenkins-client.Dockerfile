FROM jenkins/jenkins

ENV MINING_CONTROL_BACKEND /home/ubuntu/mining-control-backend
ENV JENKINS_PATH /home/ubuntu/jenkins-client
ENV ENV_JENKINS_USER adminF2M
ENV ENV_JENKINS_PASS passw0rdAdminF2M

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml
COPY casc.yaml /var/jenkins_home/casc.yaml
# COPY ./pipes/ /pipes/
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt



# USER root
# RUN apk add docker
# RUN apk add py-pip
# RUN apk add python-dev libffi-dev openssl-dev gcc libc-dev make
# RUN pip install docker-compose
ADD --chown=jenkins:jenkins ./jobs/ /var/jenkins_home/jobs/
# RUN chown -R jenkins:jenkins /var/jenkins_home/


USER jenkins