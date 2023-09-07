FROM ubuntu:18.04

SHELL ["/bin/bash", "-c"]

ENV HOME="/home/"
ENV PATH="${HOME}/miniconda3/bin:${PATH}"

WORKDIR ${HOME}

RUN apt update &&\
# install miniconda3
    apt install curl wget -y &&\
    wget https://repo.anaconda.com/miniconda/Miniconda3-py37_23.1.0-1-Linux-x86_64.sh &&\
    bash Miniconda3-py37_23.1.0-1-Linux-x86_64.sh -b &&\
    rm -f Miniconda3-py37_23.1.0-1-Linux-x86_64.sh &&\
# install DialogRPT
    apt install unzip -y &&\
    wget https://github.com/golsun/DialogRPT/archive/refs/heads/master.zip -O DialogRPT.zip &&\
    unzip DialogRPT.zip &&\
    mv DialogRPT-master DialogRPT &&\
    rm DialogRPT.zip &&\
# install requirements
    cd DialogRPT &&\
    conda install cudatoolkit=10.1 -c pytorch -y &&\
    pip install --upgrade pip &&\
    pip install -U -r requirements.txt &&\
    pip install -U numpy regex tqdm &&\
    pip install evaluate transformers bert_score

# the models can no longer be downloaded from the remote repository
# copy these files to the image
COPY DialogRPT/restore/ensemble.yml DialogRPT/restore/*.pth /home/DialogRPT/restore/

# copy the scripts to the home directory
COPY __metrics.py __evaluate.py /home/

# make a first run to install everything
COPY answer.jsonl truth.jsonl /tmp/
RUN python __evaluate.py /tmp/answer.jsonl /tmp/truth.jsonl -o scores.txt
