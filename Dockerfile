#Edited: -CultriX-
# Using ubuntu as baseimage (for ARM-support)
FROM ubuntu
CMD ["/sbin/my_init"]
WORKDIR /reddit-karma-bot
SHELL ["/bin/bash", "-c"]

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      g++ \
      gcc \
      golang-go \
      libc6-dev \
      make \
      pkg-config \
      wget \
      python3 \
      python3-pip \
      python3-setuptools \
      python3-dev \
      ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

### set up python dependencies for the bot
ADD ./src/requirements.txt requirements.txt
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install Cython
RUN python3 -m pip install wheel -r requirements.txt
COPY ./src /reddit-karma-bot-src

# run it
ENTRYPOINT [ "/bin/bash" ]
CMD [ "/reddit-karma-bot-src/run.sh" ]

