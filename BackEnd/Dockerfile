FROM openjdk:17-alpine
RUN apk add tzdata
ARG JAR_FILE=/build/libs/runnerway-0.0.1-SNAPSHOT.jar
COPY ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]