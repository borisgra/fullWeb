#Create image from source
#https://codereinvented.net/blog/
# syntax=docker/dockerfile:1
FROM gradle:jdk23 AS build
RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl
# install nodejs - https://stackoverflow.com/questions/36399848/install-node-in-dockerfile
ARG NODE_VERSION=22.0.0
ARG NODE_PACKAGE=node-v$NODE_VERSION-linux-x64
ARG NODE_HOME=/opt/$NODE_PACKAGE
ENV NODE_PATH $NODE_HOME/lib/node_modules
ENV PATH $NODE_HOME/bin:$PATH
RUN curl https://nodejs.org/dist/v$NODE_VERSION/$NODE_PACKAGE.tar.gz | tar -xzC /opt/
RUN echo "NODE Version:" && node --version

ARG ORG_GRADLE_PROJECT_isProduction="yes"
ENV ORG_GRADLE_PROJECT_isProduction=$ORG_GRADLE_PROJECT_isProduction

WORKDIR /app

# absolutely necessary .dockerignore   current dir
COPY --chown=gradle:gradle . /app

RUN gradle installDist

FROM eclipse-temurin:23-jdk-alpine AS my-jdk

# required for strip-debug to work
RUN apk add --no-cache binutils

# Build small JRE image
RUN $JAVA_HOME/bin/jlink \
    --verbose \
    --add-modules java.base,java.sql,java.management,java.naming,jdk.unsupported \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=2 \
    --output /customjre

FROM alpine:latest
ENV JAVA_HOME=/jre
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY --from=my-jdk /customjre $JAVA_HOME
COPY --from=build --chmod=777 /app/build/install/query-gra /app/

WORKDIR /app/bin

EXPOSE 9090

CMD ["./query-gra"]

# GCP: e2-micro , g1-small
# sudo docker image build --build-arg ORG_GRADLE_PROJECT_isProduction=yes --progress=plain -t borisgra/query-gra:src . 2>&1 | tee build.log
# sudo docker image build --no-cache -t borisgra/query-gra:latest .
# sudo docker login -u borisgra
# sudo docker push borisgra/query-gra:latest
# sudo docker pull borisgra/query-gra:latest
# sudo docker run borisgra/query-gra:latest -p 5004:5004
# docker builder prune  # clear cache
# df -h --total
#docker image tag d583c3ac45fd borisgra/query-gra:tagname