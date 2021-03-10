#!/bin/bash

git clone https://github.com/AlexeyAB/darknet
cd darknet
sed -ie "s/GPU=0/GPU=1/g" Makefile
sed -ie "s/CUDNN=0/CUDNN=1/g" Makefile
sed -ie "s/OPENCV=0/OPENCV=1/g" Makefile

sed -ie "s|LDFLAGS+= -L/usr/local/cuda/lib64 -lcuda -lcudart -lcublas -lcurand|LDFLAGS+= -L/usr/local/cuda/lib64 -lcudart -lcublas -lcurand -L/usr/local/cuda/lib64/stubs -lcuda|g" Makefile

sed -ie "s|NVCC=nvcc|NVCC=/usr/local/cuda/bin/nvcc|" Makefile

export CUDA_HOME=/usr/local/cuda
export DYLD_LIBRARY_PATH=/usr/local/cuda/lib:/usr/local/cuda/extras/CUPTI/lib
export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH
export PATH=$DYLD_LIBRARY_PATH:$PATH

sudo apt-get install libopencv-dev
make
