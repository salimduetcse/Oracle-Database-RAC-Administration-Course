-- target: demonstrated 'enq TX' wait event
-- this scripts randomnly updates specific 4 rows from TLOGS table.
-- it waits 4 seconds before commit every udate
-- this is done only 4 times

set feedback off
begin
 for x in 1..4 loop
  update soe.tlogs set rchars = DBMS_RANDOM.STRING('A', 20) where row_id= round(dbms_random.value(1,4));
  dbms_lock.sleep(4);
  commit;
 end loop;
end;
/
exit;
