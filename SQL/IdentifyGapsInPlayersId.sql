 declare @i int;


 SELECT @i = MAX(player_id) FROM tp_players;


 WITH tmp (gapId) AS (
   SELECT DISTINCT a.player_id + 1
   FROM tp_players a
   WHERE NOT EXISTS( SELECT * FROM tp_players b
        WHERE b.player_id  = a.player_id + 1)
   AND a.player_id < @i and a.player_id > (@i - 100000)


   UNION ALL


   SELECT a.gapId + 1
   FROM tmp a
   WHERE NOT EXISTS( SELECT * FROM tp_players b
        WHERE b.player_id  = a.gapId + 1)
   AND a.gapId < @i and a.gapId > (@i - 1000)
 )
 SELECT gapId
 FROM tmp
 ORDER BY gapId;