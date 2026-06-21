# How to enable sudo user role
---- salim is a normal user. he wants to add new user jack

[salim@rhcsa ~]$ sudo useradd jack
userdel: Permission denied.
userdel: cannot lock /etc/passwd; try again later.
[salim@rhcsa ~]$ su - root 
[root@rhcsa ~]$ visudo 
now add below line 

## Allow root to run any commands anywhere
root    ALL=(ALL)       ALL
<br> <br> 
salim  ALL=(ALL)        /sbin/useradd, /sbin/userdel

save and exit.
Now try to add and remove new users using user: salim

---- package management.
- YUM- Yellowdog Updater Modified
- DNF- Dandified
- RPM- RedHat Package Manager

<br> ![alt text](Module_03_img1.png) <br> <br>
![alt text](Module_03_img2.png) <br> <br>
![alt text](Module_03_img3.png)

[root@rhcsa ~]$ yum list 
[root@rhcsa ~]$ yum info package_name <br>
[root@rhcsa ~]$ yum grouplist <br>
[root@rhcsa ~]$ yum erase package_name 
