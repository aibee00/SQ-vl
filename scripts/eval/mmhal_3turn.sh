#!/bin/bash
# MMHal-Bench Evaluation

MODEL_BASE=vicuna-7b-v1.5
MODEL_QLORA_BASE=llava-v1.5-7b-lora
MODEL_SUFFIX=$MODEL_QLORA_BASE-3turn

python -m llava.eval.model_vqa_mmhal_3turn \
    --model-path ./checkpoints/${MODEL_QLORA_BASE} \
    --model-base ./checkpoints/${MODEL_BASE} \
    --temperature 0.0 \
    --answers-file \
    ./playground/data/eval/mmhal/answer-file-${MODEL_SUFFIX}.json --image_aspect_ratio pad --test-prompt ''

python -m llava.eval.eval_gpt_mmhal \
    --response ./playground/data/eval/mmhal/answer-file-${MODEL_SUFFIX}.json \
    --evaluation ./playground/data/eval/mmhal/review-file-${MODEL_SUFFIX}.json \
    --api-key "" \
    --gpt-model gpt-4-0613

python -m llava.eval.summarize_gpt_mmhal \
    --evaluation ./playground/data/eval/mmhal/review-file-${MODEL_SUFFIX}.json