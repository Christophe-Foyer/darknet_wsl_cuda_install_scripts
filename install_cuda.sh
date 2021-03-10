#!/bin/bash

CUDA_ARCH_BIN="5.0"
cuda_version="11-2"
cudnn_file="libcudnn8_8.1.1.33-1+cuda11.2_amd64.deb"
cudnn_lib_file="cudnn-11.2-linux-x64-v8.1.1.33.tgz"


echo "*** Installing Cuda toolkit"
# From here: https://docs.nvidia.com/cuda/wsl-user-guide/index.html

sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo apt-get update
sudo apt-get install -y cuda-toolkit-${cuda_version}


echo "*** Installing CUDNN"
# From here: https://www.reddit.com/r/bashonubuntuonwindows/comments/i0lyq4/configuring_cudnn_on_wsl/

sudo dpkg -i ${cudnn_file}
# The deb doesn't do a great job it seems, copy as well: https://docs.nvidia.com/deeplearning/cudnn/install-guide/index.html#installlinux
tar -xzvf cudnn-11.2-linux-x64-v8.1.1.33.tgz
sudo cp cuda/include/cudnn*.h /usr/local/cuda/include 
sudo cp -P cuda/lib64/libcudnn* /usr/local/cuda/lib64 
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*


echo "*** NVIDIA SMI"

sudo cp /usr/lib/wsl/lib/nvidia-smi /usr/bin/nvidia-smi
sudo chmod ogu+x /usr/bin/nvidia-smi

echo "*** CUDA PATH"
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64
