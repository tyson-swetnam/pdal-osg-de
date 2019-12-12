FROM pdal/pdal:latest

MAINTAINER "Tyson Lee Swetnam <tswetnam@cyverse.org>"

# add iCommands for iRODS
ENV ICMD_BASE="https://files.renci.org/pub/irods/releases/4.1.12/ubuntu14"
ENV ICMD_PKG="irods-icommands-4.1.12-ubuntu14-x86_64.deb"
# Install iCommands.
RUN curl -o "$ICMD_PKG" "$ICMD_BASE/$ICMD_PKG" \
        && dpkg -i "$ICMD_PKG" \
        && rm -f "$ICMD_PKG"

# Create CVFMS file system directory and "work" directory
CMD mkdir /cvmfs /work
        
# Install the wrapper script called "run_script" and a file list to be uploaded to OSG
ADD run_script /usr/bin/run_script
ADD upload_files /usr/bin/upload_files

# Make the wrapper script the default command.
CMD ["run_script"]
