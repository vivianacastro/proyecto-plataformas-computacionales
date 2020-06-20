#!/usr/bin/env bash
#
# Instalacion de 'kubectl' 
#
# AUTHOR: Viviana Castro - viviana.castro.holguin@correounivalle.edu.co
# DATE: 2020-06-20
#
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl