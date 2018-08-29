#!/bin/sh
EUREKASERVER_URI="$EUREKASERVER_PROTOCOL$EUREKASERVER_HOST:$EUREKASERVER_PORT$EUREKASERVER_CONTEXT"
CONFIGSERVER_URI="$CONFIGSERVER_PROTOCOL$CONFIGSERVER_HOST:$CONFIGSERVER_PORT"

echo "********************************************************"
echo "Waiting for the eureka server to start  on port $EUREKASERVER_PORT"
echo "********************************************************"
while ! `nc -z $EUREKASERVER_HOST $EUREKASERVER_PORT`; do sleep 3; done
echo ">>>>>>>>>>>> Eureka Server has started"

echo "********************************************************"
echo "Starting Configuration Service with Eureka Endpoint:  $EUREKASERVER_URI";
echo "********************************************************"

java -Xms800m -Xmx800m -Djava.security.egd=file:/dev/./urandom                         \
        -Dserver.port=$SERVER_PORT                                      \
        -Dspring.cloud.config.uri=$CONFIGSERVER_URI                     \
        -Dspring.profiles.active=$PROFILE                               \
        -Dspring.zipkin.baseUrl=$ZIPKINSERVER_URI                       \
        -Deureka.client.serviceUrl.defaultZone=$EUREKASERVER_URI        \
        -jar /usr/local/configservice/@project.build.finalName@.jar