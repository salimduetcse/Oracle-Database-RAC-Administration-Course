drop table soe.tlogs;
drop table soe.sn ;

create table soe.tlogs
( row_id number constraint row_id_pk primary key,
  instance_num integer,
  rchars varchar2(20),
  dml_time date);

create table soe.sn ( i number );
insert into soe.sn values ( 0 );
commit;
exit