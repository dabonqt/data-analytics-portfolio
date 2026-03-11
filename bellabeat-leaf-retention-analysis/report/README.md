# Bellabeat Leaf Retention Analysis
Project Overview

This project analyzes smart device usage data to identify behavioral patterns among users who consistently track their activity using the Bellabeat Leaf wearable device.

The goal of the analysis is to understand how user engagement behaviors differ across retention segments and to provide data-driven recommendations to improve long-term customer retention.

Business Question

How can Bellabeat increase customer retention by understanding the behavior of consistently engaged users?

Tools Used

SQL (Google BigQuery)

R (ggplot2, tidyverse)

Google Sheets

Dataset

Fitbit Fitness Tracker dataset from Kaggle.

The raw dataset was cleaned and transformed using SQL in BigQuery. Aggregated datasets used for visualization are included in this repository.

Analysis Workflow

Data cleaning and transformation using SQL

Creation of a retention proxy using tracking consistency

User segmentation based on engagement levels

Behavioral comparison across retention segments

Visualization of engagement patterns using R

Key Insights

High-consistency users demonstrate significantly higher daily activity levels and lower sedentary behavior compared to moderate and low-consistency users.

This suggests that habit formation plays a key role in long-term engagement with smart wellness devices.

Business Recommendations

Introduce streak tracking features to reinforce daily tracking habits

Implement onboarding challenges to encourage early engagement

Provide movement reminders to reduce sedentary behavior
