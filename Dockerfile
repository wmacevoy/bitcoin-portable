FROM debian:stable

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ARG USERNAME=user
ARG USERHOME=/home/$USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# ********************************************************
# * Anything else you want to do like clean up goes here *
# ********************************************************

# [Optional] Set the default user. Omit if you want to keep the default as root.
USER $USERNAME

WORKDIR $USERHOME/projects/bitcoin-portable
COPY --chown=$USERNAME:$USERNAME setup config.sh $USERHOME/projects/bitcoin-portable/
RUN ./setup

VOLUME /data
EXPOSE 8333
EXPOSE 18333
CMD ["/bin/bash","-c",". config.sh ; mkdir -p /app/data && BITCOIN_PORTABLE_NICE_EXEC bitcoind -datadir=/app/data --printtoconsole"]