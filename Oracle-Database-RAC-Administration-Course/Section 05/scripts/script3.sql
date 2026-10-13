set feedback off
begin
 for x in 1..2000 loop
  insert into soe.tlogs (row_id, instance_num, rchars, dml_time)  
  values ( s.nextval, USERENV('INSTANCE'), DBMS_RANDOM.STRING('A', 20), sysdate );
  commit;
 end loop;
end;
/
exit;

