for /l %%x in (1, 1,10) do (
 start "" sqlplus soe/soe@rac @script4.sql
)




