# Docker Install


### Faça o clone do projeto
```bash
git clone https://github.com/jorgegabrielti/docker.git
```

## **Instale o vagrant**

### **Ubuntu**
```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install vagrant
```

### **CentOS/RHEL**
```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install vagrant
```
### **Amazon Linux**
```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install vagrant
```
No diretório **"docker/vms"** temos os diretórios para construção de vms com o vagrant: 
```bash
ubuntu
centos
```

Para subir uma nova vm com o Vagrant:

### No Ubuntu
```bash
cd docker/vms/ubuntu
vagrant up
vagrant ubuntu
```

### No CentOS
```bash
cd docker/vms/centos
vagrant up
vagrant centos
```

### Após subir a vm, execute o comando:
```bash
cd /vagrant_data
./docker-install.sh 
```