git submodule update --init --recursive
# Ensure mamba is installed
mamba create -p ~/envs/finetuner python=3.10
ln -s ~/envs/finetuner ./env
mamba install pytorch torchvision torchaudio pytorch-cuda=12.4 -c pytorch -c nvidia
pip install transformers==4.44.2

# link transformer library to root
ln -s ./env/lib/python3.10/site-packages/transformers ./env-transformers
# Shallow clone LLM-Workshop repo
mkdir -p ./third-party
git clone https://github.com/GindaChen/LLM-Workshop.git ./third-party/LLM-Workshop
# add it as submodule
git submodule add https://github.com/GindaChen/LLM-Workshop.git ./third-party/LLM-Workshop

# Shallow clone transformers repo
git clone --depth 1 https://github.com/huggingface/transformers.git ./third-party/transformers
# add it as submodule
git submodule add https://github.com/huggingface/transformers.git ./third-party/transformers
