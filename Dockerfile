# Updated as of Nov 14, 2018
#FROM specified which image i want to download
# Needs to be provided before any other section of code.
FROM tomcat:8.5

#Author of the Docker File
LABEL "Maintainer"="Cusey"

#Set Catalina HOME and JAVA_OPTS
ENV CATALINA_BASE:   /usr/local/tomcat
ENV CATALINA_HOME:   /usr/local/tomcat
ENV CATALINA_TMPDIR: /usr/local/tomcat/temp
ENV JRE_HOME:        /usr
ENV CLASSPATH:       /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar

ENV PATH $PATH:$CATALINA_HOME/bin
ENV JAVA_OPTS="-Xms1024m -Xmx1024m -Xss8192k -XX:PermSize=500m -XX:CMSInitiatingOccupancyFraction=50 -XX:+ExplicitGCInvokesConcurrent -XX:+CMSClassUnloadingEnabled -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -XX:NewRatio=1 -XX:SurvivorRatio=1  -Dorg.apache.cxf.JDKBugHacks.imageIO=false"

EXPOSE 8080
EXPOSE 8009

# Need a war file from the host to be mounted you can do so here. This instruction tells docker that content in those directories does not go in images and 
# can be accessed from other containers using the --volumes-from command line parameter. You have to run the container using -v 
#/path/on/host:/path/in/container to access directories from the host.
VOLUME "/usr/local/tomcat/webapps"
VOLUME "/usr/local/tomcat/logs"

#The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile.
WORKDIR /usr/local/tomcat

# Launch Tomcat
CMD ["catalina.sh", "run"]