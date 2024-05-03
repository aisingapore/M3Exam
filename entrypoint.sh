#!/bin/bash

set -euo pipefail

[ -d data ] || git clone "https://${HF_USER}:${HF_TOKEN}@huggingface.co/datasets/aisingapore/m3exam" data

python main.py "$@"
python eval.py "$@"
