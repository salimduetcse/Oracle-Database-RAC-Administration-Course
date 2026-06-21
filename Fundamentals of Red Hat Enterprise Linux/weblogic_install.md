 # 1. First create user 
[root@silclapprnd ~]# mkdir /APP01/RBL_SIT/
[root@silclapprnd ~]# useradd RBL_SIT
[root@silclapprnd ~]# usermod -d /APP01/RBL_SIT/ -m RBL_SIT
[root@silclapprnd ~]# chown -R RBL_SIT:RBL_SIT  /APP01/RBL_SIT
[root@silclapprnd ~]# passwd RBL_SIT

# 2. Given Read, Write and Execute Permission: 755
[RBL_SIT@silclapprnd ~]# chmod -R 755 /APP01/RBL_SIT/
# 3. Copy weblogic files to the desire directory 
# 4. unzip weblogic file
[RBL_SIT@silclapprnd ~]# unzip wls12130.zip
# 5. Set Java home 
[root@silclapprnd opt]# tar -xvf jdk-8u261-linux-x64.tar.gz

x → extract
v → verbose (shows files)
f → file name

[RBL_SIT@silclapprnd ~]$ ls -la ~/.bash_profile
ls: cannot access '/APP01/RBL_SIT//.bash_profile': No such file or directory

✅ Solution: Create .bash_profile
[RBL_SIT@silclapprnd ~]$ vi ~/.bash_profile

# .bash_profile
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
export JAVA_HOME=/opt/jdk1.8.0_261
export JRE_HOME=/opt/jdk1.8.0_261/jre
export PATH=$PATH:/opt/jdk1.8.0_261/bin:/opt/jdk1.8.0_261/jre/bin:$kafka_home/bin
export PATH

# User specific environment and startup programs

[RBL_SIT@silclapprnd ~]$ source ~/.bash_profile
[RBL_SIT@silclapprnd wls12130]$ cd /APP01/RBL_SIT/wls12130

domain-registry.xml
stop.sh
start.sh

