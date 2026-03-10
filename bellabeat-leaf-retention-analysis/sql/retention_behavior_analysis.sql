CREATE OR REPLACE VIEW `leaf.retention_behavior_analysis` AS
SELECT
 rs.retention_segment,
 AVG(da.total_steps) AS avg_steps,
 AVG(da.very_active_minutes) AS avg_active_minutes,
 AVG(da.sedentary_minutes) AS avg_sedentary_minutes,
 AVG(se.sleep_efficiency) AS avg_sleep_efficiency
FROM `leaf.retention_segmented` rs
LEFT JOIN `leaf.daily_activity_cleaned` da
  ON rs.Id = da.Id
LEFT JOIN `leaf.sleep_efficiency` se
  ON rs.Id = se.Id
GROUP BY rs.retention_segment;