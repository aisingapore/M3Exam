#!/bin/bash

set -euo pipefail

python main.py "$@"
python eval.py "$@"
