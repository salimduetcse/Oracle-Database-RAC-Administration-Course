declare
 VSN number ;
begin
 for x in 1..2000 loop
  SELECT i INTO VSN FROM SOE.SN for update;
  insert into soe.tlogs (row_id, instance_num, rchars, dml_time)  
  values ( vsn+1, USERENV('INSTANCE'), DBMS_RANDOM.STRING('A', 20), sysdate );
  update soe.sn set i = i + 1;
  commit;
 end loop;
end;
/
exit;

