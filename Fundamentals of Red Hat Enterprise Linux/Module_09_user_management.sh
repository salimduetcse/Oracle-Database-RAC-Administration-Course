#users and group information details

[root@salimapp ~]# ls /etc/passwd /etc/shadow /etc/group
/etc/group  /etc/passwd  /etc/shadow

#grep stands for Global Regular Expression print

[root@salimapp ~]# grep salim /etc/passwd
salim:x:1002:1002::/home/salim:/bin/bash
salimftp:x:1005:1005::/salimftp/upload:/bin/bash
[root@salimapp ~]# grep salim /etc/shadow
salim:$6$A.ODrRaKOFbGUyK3$mSHZ/2.YjQE2sMBjK7B5pSFnbZbluNu**********QEIwxaZBA6b/2WWp5epbRXhh01:20313:0:99999:7:::
salimftp:$6$nJm7NNNI.1hz61Ps$Pk3GlBE0vxfFlvUwnmQBpqyrc********I6dN6ah8np9bYfmhHTxC6s5zDJyv0:20559:0:99999:7:::
[root@salimapp ~]# grep salim /etc/group
group   group-
[root@salimapp ~]# grep salim /etc/group
wheel:x:10:salim,doker
salim:x:1002:
salimftp:x:1005:

# linux has 2 groups information such as primary group and supplementary group. 
# primary group information show in passwd file.

# echo $? in Linux is used to display the exit status (return code) of the last executed command.
# Meaning of exit codes- (0 → Command executed successfully and Non-zero (1, 2, 127, etc.)) → Error or failure

[root@salimapp ~]# groupadd engineers
[root@salimapp ~]# groupadd admins
[root@salimapp ~]# usermod -g admins rhel
[root@salimapp ~]# id rhel
uid=1006(rhel) gid=1008(admins) groups=1008(admins)
[root@salimapp ~]# usermod -g rhel rhel
[root@salimapp ~]# id rhel
uid=1006(rhel) gid=1006(rhel) groups=1006(rhel)
[root@salimapp ~]# usermod -G  admins rhel
[root@salimapp ~]# id rhel
uid=1006(rhel) gid=1006(rhel) groups=1006(rhel),1008(admins)
[root@salimapp ~]# usermod -G engineers rhel
[root@salimapp ~]# id rhel
uid=1006(rhel) gid=1006(rhel) groups=1006(rhel),1007(engineers)
[root@salimapp ~]# usermod -aG admins  rhel
[root@salimapp ~]# id rhel
uid=1006(rhel) gid=1006(rhel) groups=1006(rhel),1007(engineers),1008(admins)

# This account is currently not available.when login user: rhel. 
[root@salimapp ~]# cat /etc/passwd | grep rhel
rhel:x:1006:1006:Redhat Linux user:/home/rhel:/sbin/nologin
# Fix it : Change the shell to /bin/bash:
[root@salimapp ~]# usermod -s /bin/bash rhel

[root@salimapp ~]# grep rhel /etc/shadow
rhel:$6$97ju9Uy8uxiNwUW9$rpFYsMKNvplspwJKfU ******* oTg3cc1QAwbl/ZPJ.lzRE4V.:20587:0:99999:7:::
##################################################
# Running commands as others users
##################################################

[root@salimapp ~]# cat /etc/passwd | grep rhel
rhel:x:1006:1006:Redhat Linux user:/home/rhel:/sbin/nologin

[root@salimapp ~]#chsh rhel
New Shell [/sbin/nologin]: /bin/bash
shell changed

# ssh configuration file
[root@salimapp /]# ls /etc/ssh/sshd_config
/etc/ssh/sshd_config

# log check 
[root@salimapp ~]# cate tail /var/log/secure

##################### ssh key management #########################
                                ssh_keygen
                                    |
                                    |
                --------------------------------------------
                |                                           |   
    ssh private key(non shareable)               ssh public key(shareable)

[salim@salimapp /]$ ssh-keygen
Generating public/private rsa key pair.
Enter file in which to save the key (/home/salim/.ssh/id_rsa):
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/salim/.ssh/id_rsa.
Your public key has been saved in /home/salim/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:SaaDrdFfxYetr0lKViNqLsBPb4VnraAeETbyZqKo7tY salim@salimapp
The key's randomart image is:
+---[RSA 3072]----+
|                 |
|           . o   |
|    . + o   + o  |
|     B * . . o   |
|   .+ X S.o.+    |
| . .o*.+oo+o.o   |
|. o .+.o+=o.. .  |
|.. E  ++oo.o o   |
|=o   ..o. . o    |
+----[SHA256]-----+

[salim@salimapp /]$ ssh-copy-id salim@172.17.231.42
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/salim/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
salim@172.17.231.42's password:
Number of key(s) added: 1
Now try logging into the machine, with:   "ssh 'salim@172.17.231.42'"
and check to make sure that only the key(s) you wanted were added.
# Now login server:dbtest using user:salim
[salim@salimapp /]$ ssh salim@172.17.231.42
Register this system with Red Hat Insights: insights-client --register
Create an account or view all your systems at https://red.ht/insights-dashboard
[salim@dbtest ~]$

########################## Copying remote files #####################
[salim@salimapp ~]$ cp /etc/redhat-release .  
[salim@salimapp ~]$ ls
Desktop    Downloads  err.txt  my_oracledb   output.txt  Public          Templates  yes
Documents  eg.txt     Music    newLocalRepo  Pictures    redhat-release  Videos     yes.pub
[salim@salimapp ~]$ cat redhat-release
Red Hat Enterprise Linux release 8.10 (Ootpa)
[salim@salimapp ~]$ scp redhat-release salim@172.17.231.42:/home/salim/
redhat-release                                                                           100%   46    51.3KB/s   00:00
[salim@salimapp ~]$ mkdir -pv /home/salim/foo #-p: parent directory
mkdir: created directory '/home/salim/foo'
[salim@salimapp ~]$ touch  /home/salim/foo/{baz,bomgle,bar}
[salim@salimapp ~]$ rsync -av /home/salim/foo salim@172.17.231.42 # -a: archive
sending incremental file list
created directory salim@172.17.231.42
foo/
foo/bar
foo/baz
foo/bomgle
sent 235 bytes  received 119 bytes  708.00 bytes/sec
total size is 0  speedup is 0.00
[salim@salimapp ~]$ touch  /home/salim/foo/{rab,zab}
[salim@salimapp ~]$ rsync -av /home/salim/foo salim@172.17.231.42
sending incremental file list
foo/
foo/rab
foo/zab
sent 235 bytes  received 58 bytes  586.00 bytes/sec
total size is 0  speedup is 0.00


# user home directory change /APP01 to /APP01/RBL_SIT/

[salim@salimapp ~]$  usermod -d /APP01/RBL_SIT/ -m RBL_SIT