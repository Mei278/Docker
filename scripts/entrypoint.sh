#!/bin/bash
if [ "$TRAIN_MODE" = "1" ]; then
  python3 -m swift train \
    --model_id_or_path /models/Qwen2.5-7B \
    --dataset "$DATASET_PATH" \
    --output_dir "$OUTPUT_DIR" \
    --deepspeed "$DEEPSPEED_CONFIG" \
    --use_lora True \
    --bf16 True
else
  python3 -m vllm.entrypoints.openai.api_server \
    --model /models/Qwen2.5-7B \
    --port 80 \
    --trust-remote-code
fi