
FROM tomcat:11-jdk21-temurin AS build

WORKDIR /app

COPY src/main/java/ /app/src/main/java/
COPY src/main/webapp/ /app/webapp/

RUN mkdir -p /app/webapp/WEB-INF/classes && \
    javac -encoding UTF-8 \
    -cp "/usr/local/tomcat/lib/servlet-api.jar:/app/webapp/WEB-INF/lib/*" \
    -d /app/webapp/WEB-INF/classes \
    $(find /app/src/main/java -name "*.java")

FROM tomcat:11-jdk21-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=build /app/webapp/ /usr/local/tomcat/webapps/ROOT/

RUN sed -i 's/port="8080"/port="${tomcat.http.port:8080}"/' /usr/local/tomcat/conf/server.xml

EXPOSE 8080

CMD ["sh", "-c", "export CATALINA_OPTS=\"$CATALINA_OPTS -Dtomcat.http.port=${PORT:-8080}\"; exec catalina.sh run"]
