#!/bin/bash -x

if [ $# -lt 1 ]; then
    echo "Usage: "
    echo "  ${0} <image_tag>"
fi

## -- mostly, don't change this --
baseDataFolder=~/data-docker
MY_IP=`ip route get 1|awk '{print$NF;exit;}'`

function displayPortainerURL() {
    port=${1}
    echo "... Go to: http://${MY_IP}:${port}"
    #firefox http://${MY_IP}:${port} &
    if [ "`which google-chrome`" != "" ]; then 
        /usr/bin/google-chrome http://${MY_IP}:${port} &
    else
        firefox http://${MY_IP}:${port} &
    fi
}

# ref: http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/

##################################################
#### ---- Mandatory: Change those ----
##################################################
imageTag=${1:-"openkbs/scikit-docker"}

PACKAGE=`echo ${imageTag##*/}|tr "/\-: " "_"`

docker_volume_data1=/notebook
docker_volume_data2=/data
local_docker_data1=${baseDataFolder}/${PACKAGE}/notebook
local_docker_data2=${baseDataFolder}/${PACKAGE}/data

#### ---- local data folders on the host ----
mkdir -p ${local_docker_data1}
mkdir -p ${local_docker_data2}

#### ---- ports mapping ----
docker_port1=8888
local_docker_port1=18888

##################################################
#### ---- Mostly, you don't need change below ----
##################################################
# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/

#instanceName=my-${1:-${imageTag%/*}}_$RANDOM
#instanceName=my-${1:-${imageTag##*/}}
instanceName=`echo ${imageTag}|tr "/\-: " "_"`

#### ----- RUN -------
echo "To run: for example"
echo "docker run -d --name ${instanceName} -v ${docker_data}:/${docker_volume_data} ${imageTag}"
echo "---------------------------------------------"
echo "---- Starting a Container for ${imageTag}"
echo "---------------------------------------------"

docker run -d --rm \
    --name=${instanceName} \
    -p ${local_docker_port1}:${docker_port1} \
    -v ${local_docker_data1}:${docker_volume_data1} \
    -v ${local_docker_data2}:${docker_volume_data2} \
    ${imageTag} 
    
echo ">>> Docker Status"
docker ps -a | grep "${instanceName}"
echo "-----------------------------------------------"
echo ">>> Docker Shell into Container `docker ps -lqa`"
echo "docker exec -it ${instanceName} /bin/bash"

#### ---- Display IP:Port URL ----
#displayPortainerURL ${local_docker_port1}

