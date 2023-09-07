FROM ubuntu:18.04 as build

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
COPY __metrics.py __evaluate.py run.py /home/

# make a first run to compile everything
COPY answer.jsonl truth.jsonl /tmp/
RUN python run.py /tmp/answer.jsonl /tmp/truth.jsonl -o /tmp/scores.txt &&\
    rm __evaluate.py __metrics.py &&\
    mv __pycache__/__evaluate.cpython-37.pyc __evaluate.pyc &&\
    mv __pycache__/__metrics.cpython-37.pyc __metrics.pyc &&\
    rm -r __pycache__

FROM ubuntu:18.04
ENV HOME="/home/"
ENV PATH="${HOME}/miniconda3/bin:${PATH}"
WORKDIR ${HOME}
COPY --from=build /home /home
