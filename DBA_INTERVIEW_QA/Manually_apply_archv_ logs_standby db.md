# How do you manually apply archive logs on a standby database?
-------------------------------------------------------------------
Discussion: 

    First, identify the archive log gap on the standby database using V$ARCHIVE_GAP or check the log apply status using V$MANAGED_STANDBY. If only a few archive logs are missing, copy the required logs from the primary server to the standby server and register them using ALTER DATABASE REGISTER LOGFILE. Once the missing logs are registered, managed recovery can continue.

    If the archive gap is large or many archive logs are missing/corrupted, manually copying hundreds of logs is not an efficient approach. In such cases, an RMAN Incremental Backup FROM SCN can be taken on the primary database, transferred to the standby database, cataloged in RMAN, and recovered. After recovery, managed standby recovery can be resumed.
Learning:

* Check archive gaps using V$ARCHIVE_GAP.
* Verify log apply status using V$MANAGED_STANDBY.
* Copy missing archive logs from Primary to Standby.
* Register logs using ALTER DATABASE REGISTER LOGFILE.
* Resume Managed Recovery Process (MRP).
* Use RMAN Incremental Backup FROM SCN for large archive gaps.
* Catalog and recover backup pieces on the standby database.

SQL Script: 
1. Check the standby apply status: 
        On the standby :
        
        SELECT DATABASE_ROLE, OPEN_MODE, MOUNTED FROM V$DATABASE;
        SELECT PROCESS, STATUS, THREAD#, SEQUENCE# FROM V$MANAGED_STANDBY;
    For Oracle 19c, V$DATAGUARD_PROCESS is preferred over the deprecated V$MANAGED_STANDBY

        Also check the last received/applied sequences:

        SELECT THREAD#, MAX(SEQUENCE#) AS LAST_RECEIVED
        FROM V$ARCHIVED_LOG GROUP BY THREAD# ORDER BY THREAD#;

        SELECT THREAD#, MAX(SEQUENCE#) AS LAST_APPLIED
        FROM V$ARCHIVED_LOG WHERE APPLIED = 'YES' GROUP BY THREAD# ORDER BY THREAD#;
2. Identify the archive gap
        On the standby:

        SELECT * FROM V$ARCHIVE_GAP;

    Example:

        THREAD#  LOW_SEQUENCE#  HIGH_SEQUENCE#
        -------  -------------  --------------
            1        1520           1525

    This means the standby needs sequences 1520–1525 for thread 1.

3. Find the archive logs on the primary

        On the primary:

        SELECT THREAD#, SEQUENCE#,NAME FROM V$ARCHIVED_LOG
        WHERE THREAD# = 1 AND SEQUENCE# BETWEEN 1520 AND 1525 ORDER BY SEQUENCE#;

    Example:

        THREAD#  SEQUENCE#  NAME
        -------  ---------  ---------------------------------------
            1        1520       /u01/archive/1_1520_123456789.arc
            1        1521       /u01/archive/1_1521_123456789.arc
            ...
            1        1525       /u01/archive/1_1525_123456789.arc
4. Copy the missing archive logs to standby

5. Register the copied archive logs

            On the standby:

            ALTER DATABASE REGISTER PHYSICAL LOGFILE
            '/u01/archive/1_1520_123456789.arc';

            ALTER DATABASE REGISTER PHYSICAL LOGFILE
            '/u01/archive/1_1521_123456789.arc';

            ALTER DATABASE REGISTER PHYSICAL LOGFILE
            '/u01/archive/1_1522_123456789.arc';

    Continue for all missing sequences.

            SELECT THREAD#, SEQUENCE#, NAME, APPLIED
            FROM V$ARCHIVED_LOG WHERE THREAD# = 1
            AND SEQUENCE# BETWEEN 1520 AND 1525 ORDER BY SEQUENCE#;
6. Start Redo Apply

            ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;
    Oracle 19c supports starting Redo Apply this way; with standby redo logs configured, this also enables real-time apply.

        Then monitor:

        SELECT PROCESS, STATUS, THREAD#, SEQUENCE# FROM V$MANAGED_STANDBY;

You may see:

            PROCESS  STATUS           THREAD#  SEQUENCE#
            -------  ---------------  -------- ----------
            MRP0     APPLYING_LOG     1        1520
            RFS      RECEIVING        1        1526

7. Verify that the gap is resolved

            Run:
            SELECT * FROM V$ARCHIVE_GAP;
    If there is no gap, it should return: no rows selected
            Then check the latest applied sequence:

            SELECT THREAD#, MAX(SEQUENCE#) AS LAST_APPLIED 
            FROM V$ARCHIVED_LOG WHERE APPLIED = 'YES' GROUP BY THREAD# ORDER BY THREAD#;
    You can also check:

            SELECT DEST_ID, STATUS, ERROR, GAP_STATUS
            FROM V$ARCHIVE_DEST_STATUS WHERE TARGET = 'STANDBY';

Practical knowledge 
   
            Copy:

            scp /u01/archive/1_1520.arc oracle@rblstandby:/u01/archive/
            scp /u01/archive/1_1521.arc oracle@rblstandby:/u01/archive/
            scp /u01/archive/1_1522.arc oracle@rblstandby:/u01/archive/
            scp /u01/archive/1_1523.arc oracle@rblstandby:/u01/archive/
            scp /u01/archive/1_1524.arc oracle@rblstandby:/u01/archive/
            scp /u01/archive/1_1525.arc oracle@rblstandby:/u01/archive/

            On standby:

            ALTER DATABASE REGISTER PHYSICAL LOGFILE '/u01/archive/1_1520.arc';
            ALTER DATABASE REGISTER PHYSICAL LOGFILE '/u01/archive/1_1521.arc';
            ALTER DATABASE REGISTER PHYSICAL LOGFILE '/u01/archive/1_1522.arc';
            ALTER DATABASE REGISTER PHYSICAL LOGFILE '/u01/archive/1_1523.arc';
            ALTER DATABASE REGISTER PHYSICAL LOGFILE '/u01/archive/1_1524.arc';
            ALTER DATABASE REGISTER PHYSICAL LOGFILE '/u01/archive/1_1525.arc';

            Start apply:

            ALTER DATABASE RECOVER MANAGED STANDBY DATABASE DISCONNECT FROM SESSION;

            Monitor:

            SELECT PROCESS, STATUS, THREAD#, SEQUENCE#
            FROM V$MANAGED_STANDBY;

            Finally:

            SELECT * FROM V$ARCHIVE_GAP;

            and:

            SELECT THREAD#, MAX(SEQUENCE#) LAST_APPLIED
            FROM V$ARCHIVED_LOG WHERE APPLIED = 'YES' GROUP BY THREAD#;         

----------------------------------------------------------------------------------
        When only a few archive logs are missing, manual archive log shipping and registration is 
        usually sufficient. For large archive gaps, RMAN incremental recovery is generally preferred 
        because it is faster and avoids rebuilding the standby database.
----------------------------------------------------------------------------------
👉 How would you resolve a standby archive gap if only 10 logs are missing? What if 500 logs are missing?

Discussion: 
        
        I would not normally copy and register 500 files one by one. First, determine the actual gap,
        That could indicate a significant Data Guard transport problem rather than a simple isolated missing archive.
        