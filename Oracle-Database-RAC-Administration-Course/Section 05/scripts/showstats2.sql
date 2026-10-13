-- retrieve and calculate how long the sessions took to load the table
SELECT (((SELECT MAX(DML_TIME) FROM SOE.TLOGS) - (SELECT MIN(DML_TIME) FROM SOE.TLOGS))* 24 * 60 * 60 ) AS SECONDS FROM  DUAL ;

-- display the number of  rows  inserted by every instance
SELECT INSTANCE_NUM, COUNT(*) FROM SOE.TLOGS GROUP BY INSTANCE_NUM ORDER BY INSTANCE_NUM;

-- retrieve the top wait events of the sessions and the average wait time for each session on the event:
col wait_class format a16
col event format a30
SELECT * FROM (
 SELECT WAIT_CLASS, EVENT,  TO_CHAR(ROUND(AVG(TIME_WAITED),2),'999,999,999.99') AVERAGE_TIME 
 FROM GV$ACTIVE_SESSION_HISTORY 
 WHERE
  SAMPLE_TIME BETWEEN TO_DATE('&BEGIN_TIME','DD-MM-YY HH24:MI:SS') AND TO_DATE('&END_TIME','DD-MM-YY HH24:MI:SS')
 AND 
  USER_ID = (SELECT USER_ID FROM DBA_USERS WHERE USERNAME='SOE')
  AND EVENT IS NOT NULL
 GROUP BY WAIT_CLASS, EVENT
 ORDER BY AVG(TIME_WAITED) DESC
 )
  WHERE ROWNUM <= 6;

exit
