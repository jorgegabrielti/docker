#!/bin/bash
# Script for installation of Docker
#
# Support for follows distributions
# 
# Amazon Linux 2
#
### Distro Detect
distro_detect () {

   # Detection of supported distros

   # Detect distro
   # FIX VERSION OF PACKAGE DOCKER FOR AMAZON LINUX 2. Other distributions 
   # are in version 19 .
   DISTRO=$(grep -Ei 'PRETTY_NAME' /etc/os-release | cut -d'=' -f2 | tr -d '"')
   
   if [ "${DISTRO}" == "Amazon Linux 2" ]; then

      if [ $(rpm -qa | grep docker) ]; then 
         echo "Docker already installed"
         exit 0 
      else 
          yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
          yum-config-manager --enable epel
          yum repolist 
          yum update -y
          yum install -y docker.x86_64
          systemctl enable --now docker
          useradd dockeruser -c "Docker User" -s /bin/bash
          usermod -aG docker dockeruser
          su -c "docker version" -l dockeruser
          echo "Docker sucefully installed"
      fi 
    
    else 
      echo "Calling http://get.docker.com"
      curl https://get.docker.com > /tmp/install.sh      
      chmod +x /tmp/install.sh
      . /tmp/install.sh
    fi 
}

### Ubuntu - Docker Install
docker-install-ubuntu ()
{
    echo "*** Distro Detected ==> [${DISTRO}] ***"
    echo "Calling http://get.docker.com ..."
    curl https://get.docker.com > /tmp/get-docker.sh      
    chmod +x /tmp/get-docker.sh
    . /tmp/get-docker.sh
}

### CentOS - Docker Install
docker-install-centos ()
{
    echo "*** Distro Detected ==> [${DISTRO}] ***"
    yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    yum-config-manager --enable epel
    yum repolist 
    yum update -y
    yum install -y docker.x86_64
    systemctl enable --now docker
    useradd dockeruser -c "Docker User" -s /bin/bash
    usermod -aG docker dockeruser
    su -c "docker version" -l dockeruser
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
        "")
            docker-install-centos
        ;;
    esac
}



distro_detect