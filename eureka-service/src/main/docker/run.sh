#!/bin/sh
echo "********************************************************"
echo "Starting the Eureka Server"
echo "********************************************************"
java -Xms800m -Xmx800m -Djava.security.egd=file:/dev/./urandom \
     -jar /usr/local/eurekaservice/@project.build.finalName@.jar
