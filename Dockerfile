FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn validate
RUN mvn clean package

FROM openjdk:11-jre-slim
ARG NAME
ARG NEW_VERSION
WORKDIR /app
COPY --from=build /app/target/${NAME}-${NEW_VERSION}.jar /app/target/app.jar
CMD ["java", "-jar", "/app/target/app.jar"]
