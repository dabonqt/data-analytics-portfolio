-- Create a cleaned view

CREATE OR REPLACE VIEW `bellabeat-case-study-487903.leaf.daily_activity_cleaned` AS
SELECT ID, 
  DATE(ActivityDate) AS activity_date,
  TotalSteps AS total_steps,

-- Trim extra decimal numbers
  ROUND(TotalDistance, 2) AS total_distance,
  ROUND(TrackerDistance, 2) AS tracker_distance,
  ROUND (LoggedActivitiesDistance, 2) AS logged_activities_distance,
  ROUND(VeryActiveDistance, 2) AS very_active_distance,
  ROUND(ModeratelyActiveDistance, 2) AS moderately_active_distance,
  ROUND(LightActiveDistance, 2) AS lightly_active_distance,
  ROUND(SedentaryActiveDistance, 2) AS sedentary_active_distance,

  VeryActiveMinutes AS very_active_minutes,
  FairlyActiveMinutes As fairly_active_minutes,
  LightlyActiveMinutes AS lightly_active_minutes,
  SedentaryMinutes AS sedentary_minutes,
  Calories AS calories

FROM `bellabeat-case-study-487903.leaf.daily_activity`;
