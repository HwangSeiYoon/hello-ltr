FROM openjdk:8-jdk-slim-buster

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        python3.7 \
        python3-pip \
        python3.7-dev \
        python3-setuptools \
        python3-wheel

# Setup a user
RUN useradd -ms /bin/bash ltr
WORKDIR /home/ltr

# Make current directory accesible
ADD . /home/ltr/hello-ltr

# Install requirements
RUN chown -R ltr.ltr hello-ltr
WORKDIR /home/ltr/hello-ltr

RUN /usr/bin/python3 -m pip install --upgrade pip
RUN pip install -r requirements.txt
USER ltr

CMD jupyter notebook --ip=0.0.0.0 --no-browser --NotebookApp.token=''
