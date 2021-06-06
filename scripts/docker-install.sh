#!/bin/bash
### Script for installation of Docker
# 
# Support the following distros present in file:
# .distros

### Ubuntu - Docker Install
docker-install-ubuntu ()
{
    echo "*** Distro Detected ==> [${DISTRO}] ***"
    echo "Calling http://get.docker.com ..."
    curl https://get.docker.com > /tmp/get-docker.sh      
    chmod +x /tmp/get-docker.sh
    . /tmp/get-docker.sh
    docker run hello-world
}

### CentOS - Docker Install
docker-install-centos ()
{
    echo "*** Distro Detected ==> [${DISTRO}] ***"
    curl -fsSL https://get.docker.com -o get-docker.sh
    sh ./get-docker.sh
    systemctl enable --now docker
    useradd dockeruser -c "Docker User" -s /bin/bash
    usermod -aG docker dockeruser
    su -c "docker version" -l dockeruser
    docker run hello-world
    echo "Docker sucefully installed"
}

### Distro detect
# Ubuntu
# CentOS
# Amazon Linux
distro_detect () 
{
    DISTRO=$(grep -Ei 'PRETTY_NAME' /etc/os-release | cut -d'=' -f2 | tr -d '"')
    
    case ${DISTRO} in 
        "Ubuntu 20.04.2 LTS")
            docker-install-ubuntu
        ;;
        "CentOS Stream 8")
            docker-install-centos
        ;;
        *)
            echo "[${DISTRO} ==> Not supported!]"
        ;;
    esac
}

distro_detect