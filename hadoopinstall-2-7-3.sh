#!/bin/bash
MIRROR=https://archive.apache.org/dist/hadoop/core/hadoop-2.7.3/hadoop-2.7.3.tar.gz

apt-get update
#apt-get -y install openjdk-7-jdk

#download hadoop, untar, put in /usr/local
cd /home/ec2-user/

wget https://archive.apache.org/dist/hadoop/core/hadoop-2.7.3/hadoop-2.7.3.tar.gz
#tar -xzf "$VERSION".tar.gz
sudo mv hadoop-2.7.3.tar.gz /usr/local/
sudo tar -xvf hadoop-2.7.3.tar.gz
rm hadoop-2.7.3.tar.gz

sudo chown -R ec2-user:ec2-user /usr/local/hadoop-2.7.3
#mv  $VERSION /usr/local
#rm "$VERSION".tar.gz



# app folder; who uses this ????

sudo    mkdir  /home/ec2-user/hadoopdata/
sudo	chown -R ec2-user:ec2-user /home/ec2-user/hadoopdata/
sudo	chmod 750 /home/ec2-user/hadoopdata/

sudo	mkdir -p /home/ec2-user/hadoopdata/datanode
sudo	chmod 750 /home/ec2-user/hadoopdata/datanode

sudo	mkdir -p /home/ec2-user/hadoopdata/namenode
sudo	chmod 750 /home/ec2-user/hadoopdata/namenode

sudo	mkdir -p /app/hadoop/tmp
sudo	chown -R ec2-user /app/hadoop/tmp
sudo	chmod 750 /app/hadoop/tmp
sudo chown -R ec2-user:ec2-user /usr/local/hadoop-2.7.3
#modify hadoop-env
#sudo cd /usr/local/$VERSION/conf
sudo cd /usr/local/hadoop-2.7.3/conf
echo "export JAVA_HOME=/usr" >> hadoop-env.sh
echo "export HADOOP_OPTS=-Djava.net.preferIPv4Stack=true" >> hadoop-env.sh


#echo all path hadoop

  echo "export HADOOP_HOME=/home/hduser/hadoop-2.7.3" >> ~/.bashrc
  source ~/.bashrc
  echo  "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> ~/.bashrc
  echo  "export HADOOP_COMMON_HOME=$HADOOP_HOME"  >> ~/.bashrc 
  echo  "export HADOOP_HDFS_HOME=$HADOOP_HOME"   >> ~/.bashrc 
  echo  "export YARN_HOME=$HADOOP_HOME"   >> ~/.bashrc 
  echo  "export HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native" >> ~/.bashrc 
  echo  "export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin" >> ~/.bashrc
  echo  "export HADOOP_INSTALL=$HADOOP_HOME" >> ~/.bashrc



#get configuration files
cd /usr/local/hadoop-2.7.3/etc/hadoop

rm core-site.xml
wget https://gist.githubusercontent.com/PiyushRaj07/6a570b296258c3d89819fb1bdb3f6d38/raw/da59fa473aa79c51a57b79d9479201384210b4c3/core-site.xml
rm   hdfs-site.xml
wget https://gist.githubusercontent.com/PiyushRaj07/da89f3935d38afe909684b90c3fee336/raw/284e565cb8d82dd751b425677a0fd4c5eed3aac9/hdfs-site.xml
rm mapred-site.xml
wget https://gist.githubusercontent.com/PiyushRaj07/9a713addd5e7c7a5dfee7647c8dec9fb/raw/24dde4a29d789fc47b178ea552f97b16a4299cfb/mapred-site.xml

# chmod, symbolic links
cd /usr/local
ln -s $VERSION hadoop

sudo su -  ec2-user -c "/usr/local/hadoop-2.7.3/bin/hadoop namenode -format"

#ssh

ssh-keygen -t rsa 
echo "please press enter"
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys 
chmod 0600 ~/.ssh/authorized_keys 

