#!/bin/bash

set -euo pipefail

if [ ! -d data/m3exam ]; then
    git clone "https://${HF_USER}:${HF_TOKEN}@huggingface.co/datasets/aisingapore/m3exam" data/m3exam
    mv data/m3exam/* data
fi

args=$(getopt -o m:e: -l main:,eval: -n 'm3exam' -- "$@")
if [ $? != 0 ]; then
    echo 'Terminating...' >&2
    exit 1
fi
eval set -- "${args}"

main_args=
eval_args=
while true; do
    case "${1}" in
        -m | --main )
            main_args=$(echo ${2} | sed 's/,--/ --/g')
            shift 2
            ;;
        -e | --eval )
            eval_args=$(echo ${2} | sed 's/,--/ --/g')
            shift 2
            ;;
        -- )
            shift
            break
            ;;
        * )
            break
            ;;
    esac
done

python main.py ${main_args}
python eval.py ${eval_args}
