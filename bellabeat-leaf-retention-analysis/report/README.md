Bellabeat Leaf Retention Analysis
Project Overview

This project analyzes smart device usage data to identify behavioral patterns among users who consistently track their activity using the Bellabeat Leaf wearable device.

The objective of the analysis is to understand how user engagement behaviors differ across retention segments and provide data-driven recommendations to improve long-term customer retention.

Business Question

How can Bellabeat increase customer retention by understanding the behavior of consistently engaged users?

Tools Used

SQL – Data cleaning, transformation, and segmentation in Google BigQuery

R – Data visualization using ggplot2

Google Sheets – Initial dataset inspection and formatting

Dataset

This project uses the Fitbit Fitness Tracker dataset available on Kaggle.

Dataset source:
https://www.kaggle.com/datasets/arashnic/fitbit

The raw dataset was cleaned and transformed using SQL in BigQuery.
The aggregated dataset used for visualization is included in this repository.

Analysis Workflow

The analysis followed the standard data analytics framework:

Ask – Define the business problem and identify stakeholders

Prepare – Identify and evaluate the dataset used for analysis

Process – Clean and transform data using SQL in BigQuery

Analyze – Segment users by tracking consistency and evaluate behavioral patterns

Share – Create visualizations in R to communicate insights

Act – Provide business recommendations based on findings

Key Visualizations

The following visualizations were created using R:

Average Daily Steps by Retention Segment

Average Sedentary Minutes by Retention Segment

Average Active Minutes by Retention Segment

Sleep Record Coverage by Retention Segment

These visualizations highlight behavioral differences across engagement levels.

Key Insights

The analysis revealed clear behavioral differences between user engagement segments:

High consistency users demonstrate significantly higher daily activity levels.

Users with consistent tracking behavior show lower sedentary time.

Engagement appears strongly associated with habit formation rather than random usage.

These insights suggest that encouraging consistent usage may improve long-term retention for Bellabeat products.

Business Recommendations

Based on the findings, the following strategies may improve user retention:

Implement activity streak features to reinforce consistent tracking habits.

Introduce onboarding challenges to encourage early engagement among new users.

Send movement reminders to users with high sedentary time.

Provide weekly progress summaries to reinforce positive behavior.
