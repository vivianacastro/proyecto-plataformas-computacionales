# proyecto-plataformas-computacionales

Proyecto final del curso Plataformas Computacionales.

## Dependencias de desarrollo

### Configurar tunneling

Para exponer el recurso a internet nos basamos en el repositorio [josanabr/tunneling-inlets](https://github.com/josanabr/tunneling-inlets), por lo tanto copiamos el archivo Vagrantfile y algunas dependencias necesarias para llevar a cabo la configuración del puente.

Para levantar la maquina virtual usamos:
```
vagrant up
```

Para entrar a la maquina virtual usamos:
```
vagrant ssh
```

Para recargar la maquina virtual usamos:
```
vagrant reload
```

### Instalar kubectl

Se instala kubectl para monitorizar el cluster. Se sigue la guía de instalación [aquí](https://kubernetes.io/docs/tasks/tools/install-kubectl/). Se instala de manera automática al crear la maquina virtual (Ver `installation-scripts/install-kubectl.sh`).

### Instalar minikube

Se instala minikube la cual es una herramienta que despliega un clúster de Kubernetes con un único nodo. Se sigue la guía de instalación [aquí](https://kubernetes.io/es/docs/tasks/tools/install-minikube/). Se instala de manera automática al crear la maquina virtual (Ver `installation-scripts/install-minikube.sh`).

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
sudo kubectl port-forward -n openfaas svc/gateway 31112:8080 &
```

Si la autenticación basica esta habilitada, iniciamos sesión usando:

```
PASSWORD=$(sudo kubectl get secret -n openfaas basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode; echo)
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







