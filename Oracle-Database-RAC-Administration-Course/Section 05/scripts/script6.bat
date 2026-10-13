sqlplus -silent soe/soe@rac @show_currenttime.sql
for /l %%x in (1, 1,19) do (
 start "" sqlplus soe/soe@rac @script6.sql
)
sqlplus soe/soe@rac @script6.sql
sqlplus -silent soe/soe@rac @show_currenttime.sql


