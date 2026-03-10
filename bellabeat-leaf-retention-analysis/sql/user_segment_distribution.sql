-- -----------------------------------------------------------
-- Count users in each retention segment
-- -----------------------------------------------------------

SELECT
  retention_segment,
  COUNT(*) AS users_in_segment

FROM leaf.retention_segmented

GROUP BY retention_segment;