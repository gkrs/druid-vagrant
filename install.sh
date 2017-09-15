#! /bin/bash -e
export DEBIAN_FRONTEND=noninteractive
echo "Updating apt-get"
apt-get -qqy update

echo "Installing prerequisites"
apt-get install -y supervisor vim less net-tools inetutils-ping curl git telnet nmap socat dnsutils netcat software-properties-common maven

echo "Adding WebUpd8 repository"
add-apt-repository -y ppa:webupd8team/java
apt-get -qqy update

echo "Installing JDK 7"
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections 
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt-get -y install oracle-java8-installer

echo "Downloading Zookeeper"
curl http://mirrors.ibiblio.org/apache/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz -o zookeeper-3.4.6.tar.gz
tar -xzf zookeeper-3.4.6.tar.gz
rm -rf zookeeper
mv zookeeper-3.4.6 zookeeper
cp zookeeper/conf/zoo_sample.cfg zookeeper/conf/zoo.cfg

echo "Downloading Druid"
curl -O http://static.druid.io/artifacts/releases/druid-0.10.1-bin.tar.gz
tar -xzf druid-0.10.1-bin.tar.gz
rm -rf druid
mv druid-0.10.1 druid
chown -R vagrant:vagrant druid

echo "Downloading Tranquility"
curl -O http://static.druid.io/tranquility/releases/tranquility-distribution-0.8.2.tgz
tar -xzf tranquility-distribution-0.8.2.tgz
rm -rf tranquility
mv tranquility-distribution-0.8.2 druid/tranquility
chown -R vagrant:vagrant druid

echo "Starting Services"
mkdir -p /var/log/{zookeeper,druid} && \
chown -R vagrant:vagrant /var/log/{zookeeper,druid}
service supervisor restart
cp /vagrant/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
supervisorctl reload
