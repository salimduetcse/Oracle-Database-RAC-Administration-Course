drop table soe.tlogs;
drop table soe.sn ;
drop sequence s;

create sequence s;

create table soe.tlogs
( row_id number constraint row_id_pk primary key,
  instance_num integer,
  rchars varchar2(20),
  dml_time date);

exit