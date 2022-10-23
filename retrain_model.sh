#!/bin/bash

# Exit script on error.
set -e
# Echo each command, easier for debugging.
set -x

usage() {
  cat << END_OF_USAGE
  Starts retraining detection model.

  --num_training_steps Number of training steps to run, 500 by default.
  --num_eval_steps     Number of evaluation steps to run, 100 by default.
  --help               Display this help.
END_OF_USAGE
}

num_training_steps=500
while [[ $# -gt 0 ]]; do
  case "$1" in
    --num_training_steps)
      num_training_steps=$2
      shift 2 ;;
    --num_eval_steps)
      num_eval_steps=$2
      shift 2 ;;    
    --help)
      usage
      exit 0 ;;
    --*)
      echo "Unknown flag $1"
      usage
      exit 1 ;;
  esac
done

#Deciding which model to use
source "/contents/colab-helper/constants.sh"
network_type="mobilenet_v1_ssd"
train_whole_model="false"
ckpt_link="${ckpt_link_map[${network_type}]}"
ckpt_name="${ckpt_name_map[${network_type}]}"

#Downloading the model as required
cd "/content/training/ckpt"
wget -O "${ckpt_name}.tar.gz" "$ckpt_link"
tar zxvf "${ckpt_name}.tar.gz"
mv "${ckpt_name}" "${CKPT_DIR}"

#Running training
python /content/models/research/object_detection/model_main.py \
  --pipeline_config_path="/content/training/ckpt/pipeline.config" \
  --model_dir="content/training/models" \
  --num_train_steps="${num_training_steps}" \
  --num_eval_steps="${num_eval_steps}"
