# Scala, sbt and circleci image
#
# https://github.com/y-matsuwitter/scala-circleci2
#
FROM  openjdk:8

ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.15

WORKDIR /root

# INSTALL Scala
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release
RUN curl https://downloads.lightbend.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar zxf - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=/root/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list && \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

RUN apt-get update
RUN apt-get install -y python \
                       python-pip \
                       mysql-client
RUN pip install awscli
