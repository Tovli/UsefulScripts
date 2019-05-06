DECLARE @xml XML

SELECT @xml = target_data
FROM   sys.dm_xe_session_targets
       JOIN sys.dm_xe_sessions
         ON event_session_address = address
WHERE  name = 'system_health'
       AND target_name = 'ring_buffer'

SELECT   
             XEventData.XEvent.query('(data/value/deadlock)[1]')  AS DeadlockGraph,
             CAST(XEventData.XEvent.value('(data/value)[1]', 'varchar(max)') AS XML) AS DeadlockGraph,
              XEventData.XEvent.value('(./@timestamp)[1]', 'DATETIME2') AS [DateTime]
FROM   (SELECT @xml AS TargetData) AS Data
       CROSS APPLY 
       TargetData.nodes ('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData (XEvent) 
ORDER BY [DateTime] DESC