# proyecto-plataformas-computacionales

## Dependencias de desarrollo

### Inatalar kubectl

https://kubernetes.io/docs/tasks/tools/install-kubectl/

### Instalar minikube

https://kubernetes.io/es/docs/tasks/tools/install-minikube/

```
minikube start
```

### Instalar arkade

Arcade nos permite instalar paquetes en Kubernetes. Remplaza la herramienta k3sup ('ketchup').

```
curl -SLsf https://dl.get-arkade.dev/ | sudo sh
```

### Inatalar OpenFaaS en minikube

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

### Crear, mpaquetar y desplegar una funcion

Para organizar debidamente el repositorio creó la carpeta `functions`. Al interior de esta carpeta se ejecutan los siguientes comandos. Para crear la función usamos:

```
faas-cli new --lang python <NOMBRE_PROYECTO>
```

Para construir nuestra función usamos el comando:

```
faas-cli build -f <NOMBRE_ARCHIVO_YML>
```

Antes de publicar la función a internet debemos logearnos en la cuenta dispuesta para Docker Hub a traves del comando `docker login --username=<USERNAME>`. Para subir la función a internet usamos el comando:

```
faas-cli push -f <NOMBRE_ARCHIVO_YML>
```

Para desplegar la función usamos el comando:
```
faas-cli deploy -f <NOMBRE_ARCHIVO_YML>
```

## Como iniciar? 





