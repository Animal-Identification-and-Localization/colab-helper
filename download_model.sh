#Sourcing constants
source "/content/colab-helper/constants.sh"

#Setting model type and some parameters
network_type="mobilenet_v1_ssd"
train_whole_model="false"
ckpt_link="${ckpt_link_map[${network_type}]}"
ckpt_name="${ckpt_name_map[${network_type}]}"

#Downloading and extracting the model
cd "/content/training/temp"
wget -O "${ckpt_name}.tar.gz" "$ckpt_link"
tar zxvf "${ckpt_name}.tar.gz"