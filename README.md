### Darknet WSL installer (WIP)

This script was made out of pure frustration, hopefully it works.

WARNING: There's a good chance this will break your install. Do be warned. Use on a new wsl install (ideally your only one, NVIDIA doesn't like to share its GPUs)

Installs darknet and opencv to use ~~with a clean miniconda~~ (rip miniconda, we're doing it live) on a clean Ubuntu 20.04 WSL installation

#### First set up your windows host properly:

follow this guide until step 3 ("Setting up CUDA Toolkit"): https://docs.nvidia.com/cuda/wsl-user-guide/index.html

#### Download the required files

Download "cuDNN Library for Linux (x86_64)" and "cuDNN Runtime Library for Ubuntu20.04 x86_64 (Deb)" from: https://developer.nvidia.com/cudnn
(you need an account)

Jot the names down to plop in the script later on.

#### Then simply run:

```bash
wget https://raw.githubusercontent.com/Christophe-Foyer/install_scripts/main/Darknet_WSL_CUDA.sh
```

Check the variables

```bash
chmod +x Darknet_WSL_CUDA.sh
./Darknet_WSL_CUDA.sh
```

Then follow prompts. ~~Make sure to initialize miniconda~~ It'll ask for a bunch of yeses, type in 1 when it asks to choose a gcc (for gcc7)

Days of my life went into this and I will never get them back. I was tired of typing variations of commands so I've now strealined bug-squashing.

Pray for no cuda errors. Feel free to ask me questions or post issues. Hope this helps!
