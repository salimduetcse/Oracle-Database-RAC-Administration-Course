# cockpit-ws refers to the Cockpit Web Service component used in Linux system management.
<< comment
cockpit-ws (Cockpit Web Service) is the backend service that:
Handles web UI connections (port 9090)
Manages authentication (PAM / system login)
Communicates with system services (systemd, logs, storage, network)
Provides APIs to the browser UI 
comment >>
[root@salimapp ~]# dnf info cockpit-ws
[root@salimapp ~]# dnf install cockpit-ws
[root@salimapp ~]# systemctl enable --now cockpit-ws
[root@salimapp ~]# firewall-cmd  --list-all
Now login to the web browser console : https://172.17.231.71:9090/ using user and password.

# firewall check
1. Check firewall service status
[root@salimapp ~]# systemctl status firewalld 
2. Check if firewall is running
[root@salimapp ~]# firewall-cmd --state
3. Check firewall rules and allowed services
[root@salimapp ~]# firewall-cmd --list-all
4. Check open ports
[root@salimapp ~]# firewall-cmd --list-ports
5. Check allowed services
[root@salimapp ~]# firewall-cmd --list-services
6. Check active zones
[root@salimapp ~]# firewall-cmd --get-active-zones

Start / Stop / Restart firewalld

[root@salimapp ~]# systemctl start firewalld
[root@salimapp ~]# systemctl stop firewalld
[root@salimapp ~]# systemctl restart firewalld