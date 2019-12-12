FROM pdal/pdal:latest

MAINTAINER "Tyson Lee Swetnam <tswetnam@cyverse.org>"

# add depende cies
RUN apt-get update -y && apt-get install -y libfuse2 libssl1.0 wget

# Install iCommands
RUN wget https://files.renci.org/pub/irods/releases/4.1.12/ubuntu14/irods-icommands-4.1.12-ubuntu14-x86_64.deb && \
    dpkg -i irods-icommands-4.1.12-ubuntu14-x86_64.deb && \
    rm irods-icommands-4.1.12-ubuntu14-x86_64.deb

# Create CVFMS file system directory and "work" directory
RUN mkdir /cvmfs /work 

# Add iRODS environment json
RUN mkdir -p /home/${USER}/.irods
ADD irods_environment.json /home/${USER}/.irods/irods_environment.json

# Install the wrapper script called "run_script" and a file list to be uploaded to OSG
ADD run_script /usr/bin/run_script
ADD upload_files /usr/bin/upload_files

# Make the wrapper script the default command.
CMD ["run_script"]
