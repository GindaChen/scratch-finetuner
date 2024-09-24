git submodule update --init --recursive

# ------------------------------------------------------------
# Prepare environment
# ------------------------------------------------------------
mamba create -p ~/envs/finetuner python=3.10 -y
mamba activate ~/envs/finetuner
mamba install pytorch torchvision torchaudio pytorch-cuda=12.4 -c pytorch -c nvidia -y
pip install flash_attn
ln -s ~/envs/finetuner ./env
pip install transformers==4.44.2

# link transformer library to root
ln -s ./env/lib/python3.10/site-packages/transformers ./env-transformers

# ------------------------------------------------------------
# Prepare submodules
# ------------------------------------------------------------
# mkdir -p ./third-party
# # LLM-Workshop
# git clone https://github.com/GindaChen/LLM-Workshop.git ./third-party/LLM-Workshop
# git submodule add https://github.com/GindaChen/LLM-Workshop.git ./third-party/LLM-Workshop

# # transformers
# git clone --depth 1 https://github.com/huggingface/transformers.git ./third-party/transformers
# git submodule add https://github.com/huggingface/transformers.git ./third-party/transformers
