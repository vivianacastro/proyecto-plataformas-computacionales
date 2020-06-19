# proyecto-plataformas-computacionales

Proyecto final del curso Plataformas Computacionales.

## Dependencias de desarrollo

### Instalar kubectl

Se instala kubectl para monitorizar el cluster. Se sigue la guía de instalación [aquí](https://kubernetes.io/docs/tasks/tools/install-kubectl/).

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl
```

### Instalar minikube

Se instala minikube la cual es una herramienta que despliega un clúster de Kubernetes con un único nodo. Se sigue la guía de instalación [aquí](https://kubernetes.io/es/docs/tasks/tools/install-minikube/). 

Para iniciar el cluster.
```
minikube start
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
kubectl rollout status -n openfaas deploy/gateway
kubectl port-forward -n openfaas svc/gateway 8080:8080 &
```

Si la autenticación basica esta habilitada, iniciamos sesión usando:

```
PASSWORD=$(kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)
echo -n $PASSWORD | faas-cli login --username admin --password-stdin

faas-cli store deploy figlet
faas-cli list
```

## Crear, empaquetar y desplegar una funcion

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

## Configurar tunneling

Para exponer el recurso creado anteriormente a internet nos basamos en el repositorio [josanabr/tunneling-inlets](https://github.com/josanabr/tunneling-inlets), por lo tanto al interior de la carpeta `tunneling` copiamos el archivo Vagrantfile y algunas dependencias necesarias para llevar a cabo la configuración del puente.





