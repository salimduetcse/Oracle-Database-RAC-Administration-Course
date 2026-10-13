-- to demonstrate the right hand index growth wait event
set feedback off
begin
 for x in 1..20000 loop
  insert into soe.tlogs (row_id, instance_num, rchars, dml_time)  
  values ( s.nextval, USERENV('INSTANCE'), DBMS_RANDOM.STRING('A', 20), sysdate );
  if mod(x,100)=0 then
   commit;
  end if;
 end loop;
 commit;
end;
/
exit;

