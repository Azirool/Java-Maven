FROM openjdk:8-jre-alpine

EXPOSE 8080

COPY ./target/java-maven-apps-*.jar /usr/app/
WORKDIR /usr/app

CMD java -jar java-maven-apps-*.jar
