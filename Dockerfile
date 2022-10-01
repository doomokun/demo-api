#FROM openjdk:19-jdk-oracle
#
## RUN apk add --no-cache bash
## COPY wait-for-it.sh /wait-for-it.sh
## RUN chmod +x /wait-for-it.sh
#
#ADD /target/api-demo-0.0.1-SNAPSHOT.jar ./api.jar
#
#EXPOSE 8080
#ENTRYPOINT ["java", "-jar", "api.jar"]


#
# Build stage
#
FROM maven:3.8.5-openjdk-17 AS build-stage
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean -DskipTests package

#
# Package stage
#
FROM openjdk:19-jdk-oracle
COPY --from=build-stage /home/app/target/api-demo-0.0.1-SNAPSHOT.jar /usr/local/lib/api.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/usr/local/lib/api.jar"]