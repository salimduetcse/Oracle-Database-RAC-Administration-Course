### What is Gather Statistics in Oracle, what information does it collect, and what do you check while the request is running?

Discussion:

    Gather Statistics collects information about tables, columns, and indexes so that the Oracle Optimizer can choose a better execution plan. While the Gather Statistics request is running, I mainly check which object is being processed, the progress of the request, start time, elapsed time, and whether the request is still running normally.

Learning:

    * Table statistics – Number of rows, blocks, and average row length.
    * Column statistics – Number of distinct values and data distribution.
    * Histograms – Provide information about uneven data distribution.
    * Index statistics – Information about index structure and distinct keys.
    * STALE statistics – Helps identify statistics that may no longer be current.
    * LAST_ANALYZED – Shows when statistics were last gathered.
    * While running – Check the object being processed, progress, start time, elapsed time, and current status.
    * After completion, verify that statistics were gathered successfully and LAST_ANALYZED is updated.

Simple Example:

    If stats gathering is running for a large table, I check which table is currently being processed and whether the request is progressing or stuck. Once completed, I verify that the statistics were successfully updated.

Real-World Note:

    For Gather Statistics, the main focus is to ensure that the required objects are processed successfully and that the optimizer statistics are updated correctly.

### What do I check while Gather Statistics is running?
    I would monitor five major areas.such as 
    1.  Is the statistics job actually running?
    2.  Check the SQL currently executing
    3.  Check long-running operations
    4.  Check CPU and I/O impact
    5.  Check wait events

# Gather statistics Script

