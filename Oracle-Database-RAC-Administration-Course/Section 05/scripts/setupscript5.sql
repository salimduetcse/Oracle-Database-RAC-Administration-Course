drop table soe.tlogs;
drop sequence s;

create sequence s
      INCREMENT BY 1
      START WITH 1
      NOMAXVALUE
      NOCYCLE
      CACHE 1000;

create table soe.tlogs
( row_id number constraint row_id_pk primary key,
  instance_num integer,
  rchars varchar2(20),
  dml_time date);

select index_name from user_indexes where table_name='TLOGS';
exit