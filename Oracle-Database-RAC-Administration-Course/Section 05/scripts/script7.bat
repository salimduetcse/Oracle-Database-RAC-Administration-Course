for /l %%x in (1, 1,19) do (
 start "" sqlplus soe/soe@soesrv2 @script7.sql
)
sqlplus soe/soe@soesrv2 @script7.sql


