FROM ubuntu:17.10

MAINTAINER Simon Egli <esp-idf_3c3aee@egli.online>

ARG USER=esp

RUN apt-get update && apt-get install -y \
        build-essential git wget unzip sudo \
        qt5-default qttools5-dev-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN groupadd -g 1000 -r $USER
RUN useradd -u 1000 -g 1000 --create-home -r $USER

#Change password
RUN echo "$USER:$USER" | chpasswd

#Make sudo passwordless
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-$USER

RUN usermod -aG sudo $USER

USER $USER

WORKDIR /home/$USER

VOLUME /QtPass

USER root

COPY provisioning/docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod +x /usr/local/bin/*

USER $USER

WORKDIR /home/$USER

ENTRYPOINT [ "/usr/local/bin/docker_entrypoint.sh" ]
