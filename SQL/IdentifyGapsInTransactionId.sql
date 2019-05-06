 declare @i int;


 SELECT @i = MAX(trans_id) FROM tt_real_transactions;


 WITH tmp (gapId) AS (
   SELECT DISTINCT a.trans_id + 1
   FROM tt_real_transactions a
   WHERE NOT EXISTS( SELECT * FROM tt_real_transactions b
        WHERE b.trans_id  = a.trans_id + 1)
   AND a.trans_id < @i and a.trans_id > (@i - 2000000)


   UNION ALL


   SELECT a.gapId + 1
   FROM tmp a
   WHERE NOT EXISTS( SELECT * FROM tt_real_transactions b
        WHERE b.trans_id  = a.gapId + 1)
   AND a.gapId < @i and a.gapId > (@i - 2000000)
 )
 SELECT gapId
 FROM tmp
 ORDER BY gapId;
 
 select top 1 * from TT_REAL_TRANSACTIONS 
 where trans_id > 424899808
 order by trans_id 
 
 