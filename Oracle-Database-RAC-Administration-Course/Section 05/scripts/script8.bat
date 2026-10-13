for /l %%x in (1, 1,19) do (
 start "" sqlplus soe/soe@lbsrv @script8.sql
)
sqlplus soe/soe@lbsrv @script8.sql


