#Create image from source
#https://codereinvented.net/blog/
# java , jre -> : gradle , eclipse-temurin ,amazoncorretto , ibm-semeru-runtimes !!!
# gradle image - from https://hub.docker.com/_/gradle
FROM gradle:jdk21 AS build

ARG ORG_GRADLE_PROJECT_isProduction="yes"
ENV ORG_GRADLE_PROJECT_isProduction=$ORG_GRADLE_PROJECT_isProduction

WORKDIR /app

COPY --chown=gradle:gradle . /app

# build app for production
RUN gradle installDist

FROM eclipse-temurin:21.0.1_12-jdk-alpine as my-jdk

# required for strip-debug to work
RUN apk add --no-cache binutils

# Build small JRE image
RUN $JAVA_HOME/bin/jlink \
    --verbose \
    --add-modules java.base,jdk.crypto.ec,java.management,java.naming,java.net.http,java.security.jgss,java.security.sasl,java.sql,jdk.httpserver,jdk.unsupported \
    --strip-debug \
    --no-man-pages \
    --no-header-files \
    --compress=2 \
    --output /customjre

FROM alpine:latest
ENV JAVA_HOME=/jre
ENV PATH="${JAVA_HOME}/bin:${PATH}"

COPY --from=my-jdk /customjre $JAVA_HOME

COPY --from=build /app/build/install/query-gra /app/

WORKDIR /app/bin

EXPOSE 9090

CMD ["./query-gra"]

# GCP: e2-micro , g1-small
# sudo docker image build --build-arg ORG_GRADLE_PROJECT_isProduction=yes --progress=plain -t borisgra/query-gra:git . 2>&1 | tee build.log
# sudo docker image build --no-cache -t borisgra/query-gra:latest .
# sudo docker login -u borisgra
# sudo docker push borisgra/query-gra:latest
# sudo docker pull borisgra/query-gra:latest
# sudo docker run borisgra/query-gra:latest -p 5004:5004
# docker builder prune  # clear cache