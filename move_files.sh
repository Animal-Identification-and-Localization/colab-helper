cd "/content/training/temp"

#Sourcing constants
source "/content/colab-helper/constants.sh"

network_type="mobilenet_v1_ssd"
ckpt_name="${ckpt_name_map[${network_type}]}"


#Removing the incorrect pipeline file
rm "${ckpt_name}/pipeline.config"

#Moving remaining model files to checkpoint directory
mv ${ckpt_name}/* "${CKPT_DIR}"