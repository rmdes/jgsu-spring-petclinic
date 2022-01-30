# Maven build container 

FROM maven:3.6.3-openjdk-11 AS maven_build

COPY pom.xml /tmp/

COPY src /tmp/src/

WORKDIR /tmp/

RUN mvn package

#pull base image

FROM openjdk

#expose port 8080
EXPOSE 8080

#default command
CMD java -jar /data/hello-world-0.1.0.jar server.port=9999

#copy hello world to docker image from builder image

COPY --from=maven_build /tmp/target/hello-world-0.1.0.jar /data/hello-world-0.1.0.jar
----

FROM maven:3.5.4-jdk-8-alpine as maven

WORKDIR /app

COPY pom.xml ./

COPY . ./

RUN mvn dependency:go-offline

RUN mvn spring-javaformat:help

RUN mvn spring-javaformat:apply

RUN mvn package

FROM openjdk:8u171-jre-alpine
EXPOSE 8080
COPY --from=maven /app/target/spring-petclinic-*.jar ./spring-petclinic.jar

CMD ["java", "-jar", "./spring-petclinic.jar"]
