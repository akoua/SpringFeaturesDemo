#https://docs.spring.io/spring-boot/reference/packaging/container-images/dockerfiles.html
FROM eclipse-temurin:21-alpine AS builder

WORKDIR /builder

ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} application.jar
RUN java -Djarmode=tools -jar application.jar extract --layers --destination extracted

FROM eclipse-temurin:21-alpine
WORKDIR /application
COPY --from=builder /builder/extracted/dependencies/ ./
COPY --from=builder /builder/extracted/spring-boot-loader/ ./
COPY --from=builder /builder/extracted/snapshot-dependencies/ ./
COPY --from=builder /builder/extracted/application/ ./

EXPOSE 90

# Execute the CDS training run
RUN java -XX:ArchiveClassesAtExit=application.jsa -Dspring.context.exit=onRefresh -jar application.jar
ENTRYPOINT ["java", "-XX:SharedArchiveFile=application.jsa ", "-jar", "application.jar"]
