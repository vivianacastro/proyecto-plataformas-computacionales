#!/usr/bin/env bash
#
# Instalacion de 'minikube' 
#
# AUTHOR: Viviana Castro - viviana.castro.holguin@correounivalle.edu.co
# DATE: 2020-06-20
#
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
chmod +x ./minikube
sudo mv ./minikube /usr/local/bin/minikube
# Kubernetes last version require conntrack
sudo apt install conntrack