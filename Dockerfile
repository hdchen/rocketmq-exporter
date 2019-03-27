FROM java:8
MAINTAINER breeze
ADD ./target/rocketmq-exporter-0.0.1-SNAPSHOT.jar demo.jar
EXPOSE 5557
ENTRYPOINT ["java","-jar","demo.jar"]
