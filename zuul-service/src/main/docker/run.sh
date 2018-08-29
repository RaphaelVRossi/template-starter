#!/bin/sh
EUREKASERVER_URI="$EUREKASERVER_PROTOCOL$EUREKASERVER_HOST:$EUREKASERVER_PORT$EUREKASERVER_CONTEXT"
CONFIGSERVER_URI="$CONFIGSERVER_PROTOCOL$CONFIGSERVER_HOST:$CONFIGSERVER_PORT"
ZIPKINSERVER_URI="$ZIPKINSERVER_PROTOCOL$ZIPKINSERVER_HOST:$ZIPKINSERVER_PORT"

echo "********************************************************"
echo "Waiting for the $EUREKASERVER_HOST to start on port $EUREKASERVER_PORT"
echo "********************************************************"
while ! `nc -z $EUREKASERVER_HOST $EUREKASERVER_PORT`; do sleep 3; done
echo "******* Eureka Server has started"

echo "********************************************************"
echo "Waiting for the $CONFIGSERVER_HOST to start on port $CONFIGSERVER_PORT"
echo "********************************************************"
while ! `nc -z $CONFIGSERVER_HOST $CONFIGSERVER_PORT`; do sleep 3; done
echo "*******  Configuration Server has started"

echo "********************************************************"
echo "Waiting for the $ZIPKINSERVER_HOST to start on port $ZIPKINSERVER_PORT"
echo "********************************************************"
while ! `nc -z $ZIPKINSERVER_HOST $ZIPKINSERVER_PORT`; do sleep 3; done
echo "******* ZIPKIN has started"

echo "********************************************************"
echo "Starting Zuul Service with $CONFIGSERVER_URI"
echo "********************************************************"

java -Xms800m -Xmx800m -Djava.security.egd=file:/dev/./urandom -Dserver.port=$SERVER_PORT     \
     -Deureka.client.serviceUrl.defaultZone=$EUREKASERVER_URI               \
     -Dspring.cloud.config.uri=$CONFIGSERVER_URI                            \
     -Dspring.profiles.active=$PROFILE                                      \
     -Dspring.zipkin.baseUrl=$ZIPKINSERVER_URI                              \
     -jar /usr/local/zuulservice/@project.build.finalName@.jar
