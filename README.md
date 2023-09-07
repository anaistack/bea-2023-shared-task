# BEA 2023 Shared Task

This repository contains the steps to obtain the data and metrics for the [BEA 2023 Shared Task on Generating AI Teacher Responses in Educational Dialogues](https://sig-edu.org/sharedtask/2023).

## Data 

To obtain the data, you must register for the shared task via [this Google Form](https://forms.gle/JhDtAMiJwadNmgKv7). Before using the data, you must sign and comply with the copyright license.

>  (1) By downloading this dataset and licence, this licence agreement is entered into, effective this date, between you, the Licensee, and the University of Cambridge, the Licensor.  (2) Copyright of the entire licensed dataset is held by the Licensor. No ownership or interest in the dataset is transferred to the Licensee.  (3) The Licensor hereby grants the Licensee a non-exclusive non-transferable right to use the licensed dataset for non-commercial research and educational purposes.  (4) Non-commercial purposes exclude without limitation any use of the licensed dataset or information derived from the dataset for or as part of a product or service which is sold, offered for sale, licensed, leased or rented.  (5) The Licensee shall acknowledge use of the licensed dataset in all publications of research based on it, in whole or in part, through citation of the following publication: Andrew Caines, Helen Yannakoudakis, Helen Allen, Pascual Pérez-Paredes, Bill Byrne, and Paula Buttery. 2022. The Teacher-Student Chatroom Corpus version 2: more lessons, new annotation, automatic detection of sequence shifts. In Proceedings of the 11th Workshop on NLP for Computer Assisted Language Learning, pages 23–35, Louvain-la-Neuve, Belgium. LiU Electronic Press. (6) The Licensee may publish excerpts of less than 100 words from the licensed dataset pursuant to clause 3.  (7) The Licensor grants the Licensee this right to use the licensed dataset 'as is'. Licensor does not make, and expressly disclaims, any express or implied warranties, representations or endorsements of any kind whatsoever.  (8) I will not attempt to de-anonymise the individual contributors to the TSCC.  (9) This Agreement shall be governed by and construed in accordance with the laws of England and the English courts shall have exclusive jurisdiction.


## Phases 1 and 2: Automated Evaluation

Because the CodaLab competition is no longer open to submissions, the CodaLab scoring program can no longer be used to compute the evaluation metrics.

A Docker image with the code for computing the metrics and for running the automated evaluation has been compiled. The image can be downloaded from the [`anaistack/bea-2023-shared-task-metrics`](https://hub.docker.com/repository/docker/anaistack/bea-2023-shared-task-metrics/) repository on Docker Hub. To download the image and run a new container, you can use the following command:

```
docker run
       --platform linux/amd64     # use a linux/amd64 platform
       -v $(pwd):/home/localdir/  # mount my local directory for further use
       -it anaistack/bea-2023-shared-task-metrics  # retrieve the image
       python run.py              # execute the automated evaluation script
       localdir/answer.jsonl      # file with generated responses
       localdir/truth.jsonl       # file with reference responses
       -o localdir/scores.txt     # output file
```

The `run.py` script reads two files: a file containing the generated responses (`answer.jsonl`) and a file containing the reference responses (`truth.jsonl`). Then, the script runs the BERTScore and DialogRPT metrics and writes the results to an output file (`scores.txt`).

For evaluating your responses on the **development set**, you can use the following command to compare your responses (`dev_answer.jsonl`) with the reference responses (`dev_with-reference.jsonl`):

```
docker run -it anaistack/bea-2023-shared-task-metrics python run.py dev_answer.jsonl dev_with-reference.jsonl
```

For evaluating your responses on the **test set**, you can use the following command to compare your responses (`test_answer.jsonl`) with the reference responses (`test_with-reference.jsonl`):

```
docker run -it anaistack/bea-2023-shared-task-metrics python run.py test_answer.jsonl test_with-reference.jsonl
```

## Phase 3: Human Evaluation

There is no code for the human evaluation phase to be released.


## Citation

If you are using the **shared task data** in your research or publication, please cite the following three references:

```bibtex
@inproceedings{caines-etal-2020-teacher,
    title = "The Teacher-Student Chatroom Corpus",
    author = "Caines, Andrew  and
      Yannakoudakis, Helen  and
      Edmondson, Helena  and
      Allen, Helen  and
      P{\'e}rez-Paredes, Pascual  and
      Byrne, Bill  and
      Buttery, Paula",
    booktitle = "Proceedings of the 9th Workshop on NLP for Computer Assisted Language Learning",
    month = nov,
    year = "2020",
    address = "Gothenburg, Sweden",
    publisher = "LiU Electronic Press",
    url = "https://aclanthology.org/2020.nlp4call-1.2",
    pages = "10--20",
}

@inproceedings{caines-etal-2022-teacher,
    title = "The Teacher-Student Chatroom Corpus version 2: more lessons, new annotation, automatic detection of sequence shifts",
    author = "Caines, Andrew  and
      Yannakoudakis, Helen  and
      Allen, Helen  and
      P{\'e}rez-Paredes, Pascual  and
      Byrne, Bill  and
      Buttery, Paula",
    booktitle = "Proceedings of the 11th Workshop on NLP for Computer Assisted Language Learning",
    month = dec,
    year = "2022",
    address = "Louvain-la-Neuve, Belgium",
    publisher = "LiU Electronic Press",
    url = "https://aclanthology.org/2022.nlp4call-1.3",
    pages = "23--35",
}

@inproceedings{tack-etal-2023-bea,
    title = "The {BEA} 2023 Shared Task on Generating {AI} Teacher Responses in Educational Dialogues",
    author = {Tack, Ana{\"\i}s  and
      Kochmar, Ekaterina  and
      Yuan, Zheng  and
      Bibauw, Serge  and
      Piech, Chris},
    booktitle = "Proceedings of the 18th Workshop on Innovative Use of NLP for Building Educational Applications (BEA 2023)",
    month = jul,
    year = "2023",
    address = "Toronto, Canada",
    publisher = "Association for Computational Linguistics",
    url = "https://aclanthology.org/2023.bea-1.64",
    doi = "10.18653/v1/2023.bea-1.64",
    pages = "785--795"
}
```

If you are using the **shared task metrics** in your research or publication, please cite the following three references:

```bibtex
@inproceedings{gao-etal-2020-dialogue,
    title = "Dialogue Response Ranking Training with Large-Scale Human Feedback Data",
    author = "Gao, Xiang  and
      Zhang, Yizhe  and
      Galley, Michel  and
      Brockett, Chris  and
      Dolan, Bill",
    booktitle = "Proceedings of the 2020 Conference on Empirical Methods in Natural Language Processing (EMNLP)",
    month = nov,
    year = "2020",
    address = "Online",
    publisher = "Association for Computational Linguistics",
    url = "https://aclanthology.org/2020.emnlp-main.28",
    doi = "10.18653/v1/2020.emnlp-main.28",
    pages = "386--395"
}

@inproceedings{zhang*_bertscore_2020,
  title = {{{BERTScore}}: {{Evaluating}} Text Generation with {{BERT}}},
  booktitle = {International {{Conference}} on {{Learning Representations}}},
  author = {Zhang*, Tianyi and Kishore*, Varsha and Wu*, Felix and Weinberger, Kilian Q. and Artzi, Yoav},
  year = {2020},
}

@inproceedings{tack-etal-2023-bea,
    title = "The {BEA} 2023 Shared Task on Generating {AI} Teacher Responses in Educational Dialogues",
    author = {Tack, Ana{\"\i}s  and
      Kochmar, Ekaterina  and
      Yuan, Zheng  and
      Bibauw, Serge  and
      Piech, Chris},
    booktitle = "Proceedings of the 18th Workshop on Innovative Use of NLP for Building Educational Applications (BEA 2023)",
    month = jul,
    year = "2023",
    address = "Toronto, Canada",
    publisher = "Association for Computational Linguistics",
    url = "https://aclanthology.org/2023.bea-1.64",
    doi = "10.18653/v1/2023.bea-1.64",
    pages = "785--795"
}
```
