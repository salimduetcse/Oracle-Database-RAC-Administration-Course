
rem Copyright (c) 2012, 2013, Oracle and/or its affiliates. All rights reserved.

set echo on

connect sys/Welcome1@pdb1 as sysdba

execute dbms_service.stop_service(service_name => 'pdb1_ac');
execute dbms_service.delete_service(service_name => 'pdb1_ac');

execute dbms_service.create_service(service_name => 'pdb1_ac', network_name => 'pdb1_ac');
execute dbms_service.start_service(service_name => 'pdb1_ac');

--rem modify service to enable AC

declare
params dbms_service.svc_parameter_array;
begin
params('FAILOVER_TYPE'):='TRANSACTION';
params('REPLAY_INITIATION_TIMEOUT'):=1800;
params('RETENTION_TIMEOUT'):=86400;
params('FAILOVER_DELAY'):=10;
params('FAILOVER_RETRIES'):=30;
params('commit_outcome'):='true';
params('aq_ha_notifications'):='true';
dbms_service.modify_service('pdb1_ac',params);
end;
/
commit;

connect hr/hr@pdb1;

drop table emp;
create table emp(
 empno number(4) not null,
 ename varchar2(10),
 job char(9),
 mgr number(4),
 hiredate date,
 sal number(7,2),
 comm number(7,2),
 deptno number(2));

insert into emp values(8839,'KING','PRESIDENT',NULL,'17-NOV-81',50000,NULL,10);
insert into emp values(8698,'BLAKE','MANAGER',NULL,'17-NOV-81',8000,NULL,10);
insert into emp values(8782,'CLARK','MANAGER',NULL,'17-NOV-81',8000,NULL,10);
insert into emp values(8566,'JONES','MANAGER',NULL,'17-NOV-81',8000,NULL,10);
insert into emp values(8654,'MARTIN','SALESMAN',NULL,'17-NOV-81',7000,NULL,10);
insert into emp values(8499,'ALLEN','MANAGER',NULL,'17-NOV-81',9000,NULL,10);
insert into emp values(8844,'TURNER','CLERK',NULL,'17-NOV-81',5000,NULL,10);
insert into emp values(8900,'JAMES','MANAGER',NULL,'17-NOV-81',9000,NULL,10);
insert into emp values(8521,'WARD','PRGRMMER',NULL,'17-NOV-81',9000,NULL,10);
insert into emp values(8902,'FORD','SALESMAN',NULL,'17-NOV-81',7000,NULL,10);
insert into emp values(8369,'SMITH','PRGRMMER',NULL,'17-NOV-81',8000,NULL,10);
insert into emp values(8788,'SCOTT','CLERK',NULL,'17-NOV-81',6000,NULL,10);
insert into emp values(8876,'ADAMS','PRGRMMER',NULL,'17-NOV-81',7000,NULL,10);
insert into emp values(8934,'MILLER','SALESMAN',NULL,'17-NOV-81',9000,NULL,10);

commit;

disconnect

