# building fPDAL version 2.0 the current latest as of 2020-02-05
FROM pdal/pdal:2.0

MAINTAINER "Tyson Lee Swetnam <tswetnam@cyverse.org>"

# add /cvmfs and /work directory for OSG integration
RUN mkdir /cvmfs /work 

# Add a few dependecies for installing iCommands
RUN apt-get update \
    && apt-get install -y lsb curl apt-transport-https python3 python-requests libfuse2 libssl1.0 wget gcc make libpcre3-dev libz-dev


# Install iCommands
RUN wget https://files.renci.org/pub/irods/releases/4.1.12/ubuntu14/irods-icommands-4.1.12-ubuntu14-x86_64.deb && \
    dpkg -i irods-icommands-4.1.12-ubuntu14-x86_64.deb && \
    rm irods-icommands-4.1.12-ubuntu14-x86_64.deb
# Add the iRODS environment
RUN mkdir -p /home/${USER}/.irods
ADD irods_environment.json /home/${USER}/.irods/irods_environment.json

WORKDIR /work

# Install DE wrapper script and script to upload output-files.
RUN wget -r -nH --cut-dirs=4 --no-parent --reject="index.html*" -e robots=off https://data.cyverse.org/dav-anon/iplant/projects/osg/ \
    && mv wrapper /usr/bin/wrapper \
    && mv upload-files /usr/bin/upload-files

# Make the wrapper script the default command.
CMD ["wrapper"]
