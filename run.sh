model_args=$(cat <<- EOM
Running M3Exam generation on ${MCKPT_MODEL_PATH}, \
${MCKPT_MODEL_PATH}, ${M3_OUTPUT_PREFIX}
EOM
)
echo $model_args

python main.py \
--setting zero-shot \
--method default \
--model_name ${MCKPT_MODEL_SIZE} \
--selected_langs "['vietnamese']" \
--selected_levels "['low', 'mid', 'high']" \
--num_samples all \
--model_path ${MCKPT_MODEL_PATH} \
--output_path ${M3_OUTPUT_PREFIX}