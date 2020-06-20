# proyecto-plataformas-computacionales

Proyecto final del curso Plataformas Computacionales. 

## ¿Como instalar?

Se brinda dos guias de instalación, una directa y otra usando una maquina virtual con Vagrant.  

### Instalación directa

Para exponer los recursos implementados a internet se baso en la guía especificada en el repositorio [josanabr/tunneling-inlets](https://github.com/josanabr/tunneling-inlets) por lo tanto se especifica como instalar Docker y gcloud.

#### Instalar Docker

Para instalar Docker usamos (Ver archivo `installation-scripts/install-docker.sh`):
```
apt-get update
apt-get -y --force-yes install docker.io
usermod -aG docker <USUARIO_SISTEMA>
```

#### Instalar gcloud

Para instalar gcloud usamos (Ver archivo `installation-scripts/install-gcloud.sh`):
```
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get -y install google-cloud-sdk
```

#### Instalar kubectl

Se instala kubectl para monitorizar el cluster. Se sigue la guía de instalación [aquí](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
```
#### Instalar minikube

Se instala minikube la cual es una herramienta que despliega un clúster de Kubernetes con un único nodo. Se sigue la guía de instalación [aquí](https://kubernetes.io/es/docs/tasks/tools/install-minikube/).

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
chmod +x ./minikube
sudo mv ./minikube /usr/local/bin/minikube
sudo apt install conntrack
```

### Instalación usando Vagrantfile

Para exponer el recurso a internet se baso en la guía especificada en el repositorio [josanabr/tunneling-inlets](https://github.com/josanabr/tunneling-inlets), por lo tanto copiamos el archivo Vagrantfile y algunas dependencias necesarias para llevar a cabo la configuración del puente. 

Además se crean los archivos `installation-scripts/install-kubectl.sh` y `installation-scripts/install-minikube.sh` para instalar kubectl y minikube respectivamente de manera automatica.

Para levantar la maquina virtual usamos:
```
vagrant up
```

Para recargar la maquina virtual usamos:
```
vagrant reload
```

Para entrar a la maquina virtual usamos:
```
vagrant ssh
```

## ¿Como iniciar?

### Iniciar minikube

Para iniciar el cluster:
```
sudo minikube start
```

Para detener el cluster:
```
sudo minikube stop
```

Para eliminar el cluster:
```
sudo minikube delete
```

Para verificar la creación del cluster usamos:
```
sudo kubectl get nodes
sudo kubectl cluster-info
```

### Instalar arkade

Arcade nos permite instalar paquetes en Kubernetes. Reemplaza la herramienta k3sup ('ketchup'). 

```
curl -SLsf https://dl.get-arkade.dev/ | sudo sh
```

### Instalar OpenFaaS en minikube

Instalamos OpenFaaS en minikube usando el siguiente comando:

```
sudo arkade install openfaas
```

### Instalar OpenFaaS cli

Instalamos OpenFaaS cli usando el siguiente comando:

```
curl -SLsf https://cli.openfaas.com | sudo sh
```

Para redireccionar el gateway a la maquina se ejecuta:

```
sudo kubectl rollout status -n openfaas deploy/gateway
sudo kubectl port-forward -n openfaas svc/gateway 8080:8080 &
```

Si la autenticación basica esta habilitada, iniciamos sesión usando:
```
PASSWORD=$(sudo kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)
echo -n $PASSWORD | faas-cli login --username admin --password-stdin

faas-cli store deploy figlet
faas-cli list
```

## ¿Como crear, empaquetar y desplegar una funcion?

Se creó la carpeta `functions`  la cual contendra nuestras funciones. Al interior de esta carpeta se ejecutan los siguientes comandos. 

Para crear la función usamos:
```
faas-cli new --lang python <NOMBRE_PROYECTO>
```

Para construir nuestra función usamos:
```
faas-cli build -f <NOMBRE_ARCHIVO_YML>
```

Antes de publicar la función debemos logearnos en la cuenta dispuesta para Docker Hub a traves del comando `docker login --username=<USERNAME>`. Para publicar la función usamos:
```
faas-cli push -f <NOMBRE_ARCHIVO_YML>
```

Para desplegar la función usamos:
```
faas-cli deploy -f <NOMBRE_ARCHIVO_YML>
```

Para probar la función usamos:
```
curl localhost:8080/function/<NOMBRE_PROYECTO> -d <PARAMETROS_FUNCION>
```

## ¿Como exponer nuestros recursos a internet?

Una vez se ha implementado la función y se verificó que funciona correctamente procedemos a exponer los recursos a internet.

### Iniciar gcloud

Para iniciar gcloud uamos:
```
gcloud init
```

Para listar los proyectos usamos:
```
gcloud projects list
```

Para eliminar un proyecto usamos:
```
gcloud projects delete <PROJECT_NUMBER>
```

### Crear nodo de salida en GCP

Antes de ejecutar el script que se encarga de crear el nodo de salida, debemos modificar `<NOMBRE_PROYECTO>` por el nombre de nuestro proyecto. Para crear el nodo de salida usamos:

```
./create-inlets-exit-node.sh
```

### Crear cliente inlets

Antes de ejecutar el script que se encarga de crear el cliente, debemos modificar 
```
REMOTE=
TOKEN=
DIGEST=
```
Con el resultado arrojado en la ejecución del script anterior. Para crear el nodo cliente usamos:
```
./create-inlets-client.sh
```


