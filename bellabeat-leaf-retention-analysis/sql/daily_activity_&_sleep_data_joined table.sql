-------------------------------------
--Join Daily Activity and Sleep data
--Allows combined behavioral analysis
-------------------------------------

CREATE OR REPLACE VIEW `bellabeat-case-study-487903.leaf.joined_activity_sleep` AS

SELECT
  da.Id,
  da.activity_date,
  da.total_steps,
  da.total_distance,
  da.very_active_minutes,
  da.sedentary_minutes,

  sl.total_sleep_records,
  sl.total_minutes_asleep,
  sl.total_time_in_bed

-- Main Table
FROM `bellabeat-case-study-487903.leaf.daily_activity_cleaned` AS da

-- Joined Table
INNER JOIN `bellabeat-case-study-487903.leaf.sleep_cleaned` AS sl

-- Join Condition
ON da.Id = sl.Id
AND da.activity_date = sl.sleep_day;