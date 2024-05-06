#!/bin/bash

set -euo pipefail

[ -d data ] || git clone "https://${HF_USER}:${HF_TOKEN}@huggingface.co/datasets/aisingapore/m3exam" data

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
