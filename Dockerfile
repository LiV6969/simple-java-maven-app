FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
COPY . .
RUN mvn validate
RUN mvn test
RUN mvn clean package
RUN mvn install

FROM openjdk:11-jre-slim
ARG NAME
ARG NEW_VERSION
WORKDIR /app
RUN echo "NAME: $NAME"
RUN echo "NEW_VERSION: $NEW_VERSION"
COPY --from=build /app/target/${NAME}-${NEW_VERSION}.jar /app/target/${NAME}-${NEW_VERSION}.jar
CMD ["java", "-jar", "/app/target/${NAME}-${NEW_VERSION}.jar"]

