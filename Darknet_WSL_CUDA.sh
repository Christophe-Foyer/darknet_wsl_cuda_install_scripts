#!/bin/bash

echo "This script assumes the wsl container is set up for CUDA"
echo "You can download the CUDNN Package at: https://developer.nvidia.com/cudnn"
echo "Check the variables at the top of this file before running (especially CUDA_ARCH_BIN, see https://en.wikipedia.org/wiki/CUDA for the version supported by your GPU)"

# TODO: replace the CUDA_ARCH_BIN in the opencv script based on a variable here

[[ "$(read -e -p 'Continue? [y/N]> '; echo $REPLY)" == [Yy]* ]] && echo Continuing || (exit 1 && echo Stopping)


CUDA_ARCH_BIN="5.0"
ubuntu_version="ubuntu2004"
cuda_version="11-2"
cudnn_file="libcudnn8.deb"

sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/${ubuntu_version}/x86_64/7fa2af80.pub

export ubuntu_version
sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/${ubuntu_version}/x86_64 /" > /etc/apt/sources.list.d/cuda.list'

sudo apt-get update

sudo apt-get install -y cuda-toolkit-${cuda_version}

sudo cp /usr/lib/wsl/lib/nvidia-smi /usr/bin/nvidia-smi
sudo chmod ogu+x /usr/bin/nvidia-smi

sudo dpkg -i ${cudnn_file}

Echo "Installing Opencv"

wget https://raw.githubusercontent.com/Christophe-Foyer/install_scripts/main/opencv_install_virtualenv.sh

sed -ie 's/CUDA_ARCH_BIN="5.0"/CUDA_ARCH_BIN="${CUDA_ARCH_BIN}"/g' opencv_install_virtualenv.sh

bash opencv_install_virtualenv.sh

# Is this dumb to do after it alread has it installed?
sudo apt install libopencv-dev -y

echo "Installing Darknet"

git clone https://github.com/AlexeyAB/darknet
cd darknet
sed -ie "s/GPU=0/GPU=1/g" Makefile
sed -ie "s/CUDNN=0/CUDNN=1/g" Makefile
sed -ie "s/OPENCV=0/OPENCV=1/g" Makefile

sed -ie "s/LDFLAGS+= -L/usr/local/cuda/lib64 -lcuda -lcudart -lcublas -lcurand/LDFLAGS+= -L/usr/local/cuda/lib64 -lcudart -lcublas -lcurand -L/usr/local/cuda/lib64/stubs -lcuda/g" Makefile

make
