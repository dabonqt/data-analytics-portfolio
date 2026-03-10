CREATE OR REPLACE VIEW `bellabeat-case-study-487903.leaf.sleep_cleaned` AS
SELECT Id,
DATE(Sleep_Day) AS sleep_day,
Total_Sleep_Records AS total_sleep_records,
Total_Minutes_Asleep AS total_minutes_asleep,
Total_Time_in_Bed AS total_time_in_bed
FROM `bellabeat-case-study-487903.leaf.sleep`