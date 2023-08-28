#
# Build stage
#
FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY src ./src
COPY pom.xml .
RUN mvn -f pom.xml clean package

#
# Package stage
#
FROM openjdk:17-jdk-slim AS production
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 80
ENTRYPOINT ["java","-jar","app.jar"]