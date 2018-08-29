# Introduction
Welcome to VVS Project.  

By the time you are done reading this chapter you will have built and/or deployed:

1.  A Spring Cloud Config server that is deployed as Docker container and can manage a services configuration information using a file system or GitHub-based repository.
2.  A Eureka server running as a Spring-Cloud based service.  This service will allow multiple service instances to register with it.  Clients that need to call a service will use Eureka to lookup the physical location of the target service.
3.  A province service that will manage provinces data used within vvs project.
4.  A OracleXE SQL database used to hold the data for the services.

# Software needed
1.	Apache Maven (http://maven.apache.org). I used version 3.3.9 of the Maven.
2.  Oracle JDK version 8.
3.	Docker (http://docker.com). The code uses Docker V1.12 and above. I am taking advantage of the embedded DNS server in Docker that came out in release V1.11. New Docker releases are constantly coming out so it's release version you are using may change on a regular basis.
4.	Git Client (http://git-scm.com). All of the source code is stored in a GitHub repository.

# Building the Docker Images for VVS
To build the code examples for vvs as a docker image, open a command-line window change to the directory where you have downloaded the vvs source code.

Run the following maven command.  This command will execute the [Spotify docker plugin](https://github.com/spotify/docker-maven-plugin) defined in the pom.xml file.  

   **mvn clean install docker:build**

 Running the above command at the root of the project directory will build all of the projects.  If everything builds successfully you should see a message indicating that the build was successful.

# Running the services VVS

Now we are going to use docker-compose to start the actual image.  To start the docker image,
change to the directory containing  your vvs source code.  Issue the following docker-compose command:

   **docker-compose -f docker/common/docker-compose.yml up**

If everything starts correctly you should see a bunch of Spring Boot information fly by on standard out.  At this point all of the services needed for the vvs code examples will be running.

# Install Oracle - JDBC maven locally

If no one jdbc is install, run this command.

<code>mvn install:install-file -Dfile=(File to ojdbc7.jar) -DgroupId=com.oracle -DartifactId=ora-jdbc -Dversion=7 -Dpackaging=jar</code>