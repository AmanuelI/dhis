
# Update the base image to a newer version
FROM tomcat:9-jre8

# Remove the existing ROOT directory in the webapps folder
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the hibernate.properties and dhis.conf files to the config folder
COPY conf/hibernate.properties /opt/dhis2/config/hibernate.properties
COPY conf/dhis.conf /opt/dhis2/config/dhis.conf

# Copy the dhis2.war file to the webapps folder and rename it to ROOT.war
COPY releases/dhis2.war /usr/local/tomcat/webapps/ROOT.war

# Copy the wait-for-it.sh script to the container
COPY wait-for-it.sh wait-for-it.sh

# Update the setenv.sh file to configure JAVA_OPTS and DHIS2_HOME
RUN echo "export JAVA_OPTS='$JAVA_OPTS'" >> /usr/local/tomcat/bin/setenv.sh
RUN echo "export DHIS2_HOME='/opt/dhis2/config'" >> /usr/local/tomcat/bin/setenv.sh
