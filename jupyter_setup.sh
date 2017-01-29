#!/bin/bash

echo -e "\nSetting up Jupyter notebook..."
conda install -c conda-forge jupyter_contrib_nbextensions
mkdir -p $(jupyter --data-dir)/nbextensions
cd $(jupyter --data-dir)/nbextensions
git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding
chmod -R go-w vim_binding

pip install jupyterthemes
jt -t onedork -vim -T -N
