FROM ubuntu:16.04
MAINTAINER thamutafkng8st

ADD hao.sh /usr/local/bin/
RUN touch testfile
RUN chmod 755 /usr/local/bin/hao.sh

USER root
RUN apt-get update && apt-get install -y \
  openjdk-8-jdk \
  unzip zip git bzip2 curl gnupg2 \
  apt-transport-https \
  ca-certificates \
  software-properties-common \
  python-software-properties


# Add letsencrypt CA certificate
RUN curl https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem.txt -o /usr/share/ca-certificates/lets-encrypt-x3-cross-signed.pem
RUN echo "lets-encrypt-x3-cross-signed.pem" >> /etc/ca-certificates.conf
RUN update-ca-certificates

# install jenkins swarm client
RUN curl -L "https://nexus3.base2d.com/repository/projects-public/swarm-client-3.6.jar" -o /usr/local/bin/swarm-client.jar
WORKDIR /home/jenkins

CMD tail -f /dev/null

