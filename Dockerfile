FROM eclipse-temurin:21-noble AS builder

WORKDIR /builder
# Copy the current directory contents into the container at /app
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=tools -jar application.jar extract --layers --destination extracted

FROM eclipse-temurin:21-noble
WORKDIR /application
COPY --from=builder /builder/extracted/dependencies/ ./
COPY --from=builder /builder/extracted/spring-boot-loader/ ./
COPY --from=builder /builder/extracted/snapshot-dependencies/ ./
COPY --from=builder /builder/extracted/application/ ./
# Make port 80 available to the world outside this container
EXPOSE 90
ENTRYPOINT ["java", "-jar", "application.jar"]
