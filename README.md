# scikit

[![](https://imagelayers.io/badge/openkbs/scikit:latest.svg)](https://imagelayers.io/?images=openkbs/scikit:latest 'Get your own badge on imagelayers.io')

##Components:
- ref: https://github.com/davidshen84/docker-scikit-learn
- ref: https://github.com/davidshen84/docker-jupyter

## Pull the image from Docker Repository

```bash
docker pull openkbs/scikit
```
## Login password/token (from jupyter screen)
Token authentication is enabled. You need to open the notebook server with its first-time login token in the URL, or enable a password in order to gain access. After you get in the container, the command to show token is 
```
jupyter notebook list
```
will show you the URLs of running servers with their tokens, which you can copy and paste into your browser. For example:
```
Currently running servers:
http://localhost:8888/?token=c8de56fa... :: /Users/you/notebooks
```
Or you can paste just the token value into the password field on this page.

Cookies are required for authenticated access to notebooks.

## Or, just show the docker log to see the token
```
docker ps -a |grep scikit (to see the container id)
then,
docker logs <container_id>
```

## Connect to scikit Docker
host/port=> 0.0.0.0:18888 
login/passwd=> (see above)

## Base the image to build add-on components

```Dockerfile
FROM openkbs/scikit
```

## Run the image

Then, you're ready to run:
- make sure you create your work directory, e.g., ./data

```bash
mkdir ./data
docker run -d --name my-scikit -p 18888:8888 openkbs/scikit
```

## Build and Run your own image
Say, you will build the image "my/scikit".

```bash
docker build -t my/scikit .
```

To run your own image, say, with some-scikit:

```bash
mkdir ./data
docker run -d --name some-scikit -p 18888:8888 my/scikit
```

## Shell into the Docker instance

```bash
docker exec -it some-scikit /bin/bash
```


