FROM maven:3.5.4-jdk-8-alpine as maven

WORKDIR /app

COPY pom.xml ./

COPY . ./

RUN mvn dependency:go-offline

RUN mvn spring-javaformat:help

RUN mvn spring-javaformat:apply

RUN mvn package

FROM adoptopenjdk/openjdk11:ubi
EXPOSE 8080
COPY --from=maven /app/target/*.jar ./spring-petclinic.jar

CMD ["java", "-jar", "./spring-petclinic.jar"]
