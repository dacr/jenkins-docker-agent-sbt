FROM openjdk:8-jdk-alpine
MAINTAINER David Crosson <crosson.david@gmail.com>
LABEL org.label-schema.vcs-url="https://github.com/dacr/jenkins-docker-agent-sbt"

ENV SBT_VERSION=1.0.3 \
    SBT_HOME=/usr/local/sbt \
    TOOL_USER=sbt \
    TOOL_USER_HOME=/home/sbt

ENV PATH=${SBT_HOME}/bin:${PATH}

RUN apk add --update curl ca-certificates bash git bc && \
    rm -rf /var/cache/apk/*

RUN adduser -S -h ${TOOL_USER_HOME} ${TOOL_USER} && \
    chown -R ${TOOL_USER} ${TOOL_USER_HOME} 

RUN curl -sL /tmp/sbt-${SBT_VERSION}.tgz "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" \
       | gunzip \
       | tar -x -C /usr/local

WORKDIR ${TOOL_USER_HOME}
USER ${TOOL_USER}

RUN git config --global user.email "crosson.david@gmail.com" && \
    git config --global user.name "Jenkins Build Docker Agent"

USER root
RUN chmod a+rwx ${TOOL_USER_HOME} && \
    find ${TOOL_USER_HOME} -type d | xargs chmod a+rwx && \
    find ${TOOL_USER_HOME} -type f | xargs chmod a+rw

USER ${TOOL_USER}

