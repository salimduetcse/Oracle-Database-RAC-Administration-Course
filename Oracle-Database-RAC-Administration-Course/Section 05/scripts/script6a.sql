-- Script procedure:
-- create  the first 20 tables, fill their data, gather their stats, select randomly 100 rows from every table, drop the tables
DECLARE
 v varchar2(40);
begin
for x in 1..20 loop
 -- create the tables:
 execute immediate 'create table soe.tlogs' || x ||
  '( row_id number primary key,' ||
  '  instance_num integer,' ||
  '  rchars varchar2(20),' ||
  '  dml_time date)';
 -- fill the data
 for y in 1..1000 loop
  execute immediate ' insert into soe.tlogs'|| x ||' (row_id, instance_num, rchars, dml_time)  '||
  'values ( '|| y ||', USERENV(''INSTANCE''), DBMS_RANDOM.STRING(''A'', 20), sysdate )';
 end loop;
 commit;
 DBMS_STATS.gather_table_stats(ownname =>'SOE', tabname=>'TLOGS'||x, cascade=>true);
end loop;
for x in 1..20 loop 
 for y in 1..100 loop
  execute immediate 'select rchars from soe.tlogs'||x || ' where row_id='|| round(dbms_random.value(1,1000)) into v;
 end loop;
end loop;
for x in 1..20 loop 
 execute immediate 'drop table soe.tlogs'||x;
end loop;
end;
/

exit;
