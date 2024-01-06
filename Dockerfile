# Stage 1: Build stage
FROM maven:3.6.0-jdk-17-slim AS build
WORKDIR /app
COPY . .
RUN mvn validate
RUN mvn test
RUN mvn clean package
RUN mvn install

# Stage 2: Final image
FROM openjdk:17-jre-slim
ARG NAME
ARG NEW_VERSION
WORKDIR /app
COPY --from=build /app/target/${NAME}-${NEW_VERSION}.jar /app/target/${NAME}-${NEW_VERSION}.jar
CMD ["java", "-jar", "/app/target/${NAME}-${NEW_VERSION}.jar"]

