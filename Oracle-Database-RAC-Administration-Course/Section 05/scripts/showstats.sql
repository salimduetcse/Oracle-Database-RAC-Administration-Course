select (((select max(dml_time) from soe.tlogs) - (select min(dml_time) from soe.tlogs))* 24 * 60 * 60 ) as seconds from  dual ;

select instance_num, count(*) from soe.tlogs group by instance_num order by instance_num;


col wait_class format a16
col event format a30
select * from (
 select wait_class, event,  to_char(round(avg(time_waited),2),'999,999,999.99') Average_Time 
 from gV$ACTIVE_SESSION_HISTORY 
 where
 sample_time between to_date('&begin_time','dd-mm-yy hh24:mi:ss') and to_date('&end_time','dd-mm-yy hh24:mi:ss')
 and 
 user_id = (select user_id from dba_users where username='SOE')
 and event is not null
 group by wait_class, event
 order by avg(time_waited) desc
 )
  WHERE ROWNUM <= 6;

exit
