CREATE OR REPLACE VIEW `leaf.user_retention_summary` AS

--Create a temporary table
WITH user_activity_days AS (
  SELECT 
    Id,
    COUNT(DISTINCT activity_date) AS active_days
  FROM `bellabeat-case-study-487903.leaf.daily_activity_cleaned`
  GROUP BY Id 
  ),
  
total_days AS (
  SELECT COUNT(DISTINCT activity_date) AS dataset_days
  FROM `bellabeat-case-study-487903.leaf.daily_activity_cleaned`
  )

SELECT
  u.Id,
  u.active_days,
  t.dataset_days,
  SAFE_DIVIDE(u.active_days, t.dataset_days) AS tracking_consistency_rate
FROM user_activity_days u
CROSS JOIN total_days t




