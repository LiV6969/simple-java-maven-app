# Stage 1: Build stage
FROM maven:3.6.8-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn validate
RUN mvn test
RUN mvn clean package
RUN mvn install

# Stage 2: Final image
FROM openjdk:11-jre-slim
ARG NAME
ARG NEW_VERSION
WORKDIR /app
COPY --from=build /app/target/${NAME}-${NEW_VERSION}.jar /app/target/${NAME}-${NEW_VERSION}.jar
CMD ["java", "-jar", "/app/target/${NAME}-${NEW_VERSION}.jar"]

