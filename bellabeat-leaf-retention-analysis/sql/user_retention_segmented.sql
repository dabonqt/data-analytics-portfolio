CREATE OR REPLACE VIEW leaf.retention_segmented AS
SELECT *,
CASE
  WHEN tracking_consistency_rate >= 0.80 THEN 'High Consistency'
  WHEN tracking_consistency_rate >= 0.50 THEN 'Moderate Consistency'
  ELSE 'Low Consistency'
END AS retention_segment
FROM `bellabeat-case-study-487903.leaf.user_retention_summary`
