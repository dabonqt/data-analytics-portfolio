--------------------------------
--Calculate Sleep Efficiency
--Measure Sleep quality
--------------------------------

CREATE OR REPLACE VIEW `leaf.sleep_efficiency` AS
SELECT *,
SAFE_DIVIDE(total_minutes_asleep, total_time_in_bed) AS sleep_efficiency
FROM `bellabeat-case-study-487903.leaf.joined_activity_sleep`
