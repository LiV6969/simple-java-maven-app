# Stage 1: Build stage using Maven
FROM maven:3.8.6-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy all files from the current directory into the working directory
COPY . .

# Execute Maven validate to check the project's correctness and availability of necessary information
RUN mvn validate

# Execute Maven clean package to clean the project and package the application
RUN mvn clean package

# Stage 2: Create a minimal runtime image
FROM openjdk:11-jre-slim

# Define build-time arguments
ARG NAME
ARG NEW_VERSION

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage to the working directory of the current stage
COPY --from=build /app/target/${NAME}-${NEW_VERSION}.jar /app/target/app.jar

# Specify the default command to run the Java application when the container starts
CMD ["java", "-jar", "/app/target/app.jar"]
