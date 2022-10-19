FROM openjdk:19-jdk-oracle

RUN mkdir /app

WORKDIR /app

COPY target/api-demo-0.0.1-SNAPSHOT.jar /app/api.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/usr/local/lib/api.jar"]