FROM nvcr.io/nvidia/cuda:8.0-cudnn6-runtime-ubuntu16.04


# Install python 3.6
RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
RUN apt-get install -y wget \
    build-essential zlib1g-dev \
    curl libssl-dev git libglib2.0-0 \
    libsm6 libxext6 libxrender-dev \
    python3-tk python3-dev tcl-dev python-tk\
    tk-dev libffi-dev

RUN wget https://www.python.org/ftp/python/3.6.9/Python-3.6.9.tgz
RUN tar -xf Python-3.6.9.tgz
RUN cd Python-3.6.9 && ./configure && make && make install
RUN ln /usr/local/bin/python3 /usr/local/bin/python
RUN ln /usr/local/bin/pip3 /usr/local/bin/pip

RUN apt-get install -y --force-yes  \
    python3-tk python3-dev tcl-dev python-tk\
    tk-dev libffi-dev


# #Install dependencies
COPY requirements.txt requirements.txt
RUN pip install numpy==1.14.0 Cython==0.29.13 setuptools==31.0
ENV USER app
RUN pip install -r requirements.txt

WORKDIR /home/app