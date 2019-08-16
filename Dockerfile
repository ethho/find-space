FROM enho/protpy:0.1.1

### DO NOT EDIT BELOW ###
# Install software to make containers interactive
#   Debian-like
ARG FOUNDATIONS="bash curl git man rsync vim"
RUN if [ -f "/etc/os-release" ] && \
    grep "debian" /etc/os-release; \
    then apt-get update -qqq && \
    apt-get install -qqq -y -u apt-utils ${FOUNDATIONS} && \
    apt-get clean -qqq; fi
#   RHEL-like
RUN if [ -f "/etc/os-release" ] && \
    grep "rhel" /etc/os-release; then \
    yum -q updateinfo && \
    yum -q -y install ${FOUNDATIONS} && \
    yum -q clean all; rm -rf /var/cache/yum; fi
#   Alpine
RUN if [ -f "/etc/os-release" ] && \
    grep "alpine" /etc/os-release; then \
    apk update -q && \
    apk add -q ${FOUNDATIONS}; \
    fi
# Add shadow mount points image mapped to TACC storage
RUN for MOUNT in corral data gpfs projects scratch work; \
    do mkdir -p /${MOUNT}; \
    chown root:root /${MOUNT}; \
    chmod ug+rwx,o+rx /${MOUNT}; \
    done
# These variables used by TACC.cloud components
ENV _PROJ_CORRAL=/corral
ENV _PROJ_STOCKYARD=/work/projects/SD2E-Community
ENV _USER_WORK=
### DO NOT EDIT ABOVE ###

# Customize your Docker container starting here

# ENV PATH "/opt/bin/:$PATH"
# ADD config.yml /config.yml
# ADD src /opt/src

