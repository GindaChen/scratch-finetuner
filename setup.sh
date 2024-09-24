git submodule update --init --recursive
# Ensure mamba is installed
mamba create -p ~/envs/finetuner python=3.10
ln -s ~/envs/finetuner ./env
mamba install pytorch torchvision torchaudio pytorch-cuda=12.4 -c pytorch -c nvidia
pip install transformers