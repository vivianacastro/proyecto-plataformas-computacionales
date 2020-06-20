Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision "shell", path: "./installation-scripts/install-asciinema.sh"
  config.vm.provision "shell", path: "./installation-scripts/install-docker.sh"
  config.vm.provision "shell", path: "./installation-scripts/install-gcloud.sh"
  config.vm.provision "shell", path: "./installation-scripts/install-kubectl.sh"
  config.vm.provision "shell", path: "./installation-scripts/install-minikube.sh"
  config.vm.network "forwarded_port", guest: 5000, host: 5000  
end