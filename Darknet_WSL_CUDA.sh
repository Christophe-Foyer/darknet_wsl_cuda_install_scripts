echo "This script assumes the wsl container is set up for CUDA"
echo "It also assumes you have the CUDNN deb in your current working directory with a specific filename (libcudnn8.deb)"
echo "It specifically installs cuda toolkit 11.2"
echo "It also assumes your cuda arch is 5.0 for now (check gpu)"

CUDA_ARCH_BIN="5.0"

# TODO: replace the CUDA_ARCH_BIN in the opencv script based on a variable here

[[ "$(read -e -p 'Continue? [y/N]> '; echo $REPLY)" == [Yy]* ]] && echo Continuing || (echo Stopping && exit 1)

sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub

sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list'

sudo apt-get update

sudo apt-get install -y cuda-toolkit-11-2

sudo cp /usr/lib/wsl/lib/nvidia-smi /usr/bin/nvidia-smi
sudo chmod ogu+x /usr/bin/nvidia-smi

sudo dpkg -i libcudnn8.deb

Echo "Installing Opencv"

wget https://raw.githubusercontent.com/Christophe-Foyer/install_scripts/main/opencv_install.sh

#sed -ie 's/CUDA_ARCH_BIN="5.0"/CUDA_ARCH_BIN="${CUDA_ARCH_BIN}"/g' Makefile

bash opencv_install.sh

echo "Installing Darknet"

git clone https://github.com/AlexeyAB/darknet
cd darknet
sed -ie "s/GPU=0/GPU=1/g" Makefile
sed -ie "s/CUDNN=0/CUDNN=1/g" Makefile
sed -ie "s/OPENCV=0/OPENCV=1/g" Makefile

make
