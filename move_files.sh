
cd "/content/training/temp"

#Sourcing constants
source "/content/colab-helper/constants.sh"

#Removing the incorrect pipeline file
rm "${ckpt_name}/pipeline.config"

#Moving remaining model files to checkpoint directory
mv "${ckpt_name}/*" "${CKPT_DIR}"