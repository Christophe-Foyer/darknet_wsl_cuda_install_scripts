### Darknet WSL installer

This is actually a bit less scary than it looks now that I'm on the other side, here's something that will hopefully make your lives easier.

#### About

This script was made out of pure frustration, hopefully it works. Feel free to post issues/ask questions!

WARNING: There's a good chance this will break your install. Do be warned. Use on a new wsl install (ideally your only one, NVIDIA doesn't like to share its GPUs)

Installs darknet and opencv to use ~~with a clean miniconda~~ (rip miniconda, we're doing it live) on a clean Ubuntu 20.04 WSL installation

#### First set up your windows host properly:

follow this guide until step 3 ("Setting up CUDA Toolkit"): https://docs.nvidia.com/cuda/wsl-user-guide/index.html

###### AKA:
- Get on the windows insider builds (anything above 20145 I believe)
- Download the NVIDIA Driver
- Install WSL2

#### Download the required files

Download "cuDNN Library for Linux (x86_64)" and "cuDNN Runtime Library for Ubuntu20.04 x86_64 (Deb)" from: https://developer.nvidia.com/cudnn
(you need an account)

Put them on your wsl home folder
Jot the names down to plop in the script later on.

#### Run the script
(ideally from your home folder, that's where it was tested)

```bash
wget https://raw.githubusercontent.com/Christophe-Foyer/install_scripts/main/Darknet_WSL_CUDA.sh
```

Check the variables before running with
```bash
nano Darknet_WSL_CUDA.sh
```

Change the variables to suit your GPU/Preferences/downloaded files and/or prefered deity to pray this works. 
(I've really spent a full week trying to install this.)

```bash
CUDA_ARCH_BIN="5.0"
cuda_version="11-2"
cudnn_file="libcudnn8_8.1.1.33-1+cuda11.2_amd64.deb"
cudnn_lib_file="cudnn-11.2-linux-x64-v8.1.1.33.tgz"
```

Now run it:
```bash
chmod +x Darknet_WSL_CUDA.sh
./Darknet_WSL_CUDA.sh
```

Then follow prompts. ~~Make sure to initialize miniconda~~ It'll ask for a bunch of yeses, type in 1 when it asks to choose a gcc (for gcc7)

Days of my life went into this and I will never get them back. I was tired of typing variations of commands so I've now strealined bug-squashing.

Pray for no cuda errors (if it throws "cudaErrorInsufficientDriver" check [here](https://forums.developer.nvidia.com/t/cuda-sample-throwing-error/142537), it's probably not happy that it has to share the GPU). Feel free to ask me questions or post issues. Hope this helps!

## TODO:
Put in install_cuda as a script that's run instead of a duplicate, non-issue when running
