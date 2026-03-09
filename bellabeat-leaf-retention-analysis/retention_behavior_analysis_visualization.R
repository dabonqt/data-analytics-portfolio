# -----------------------------------------------------------
# Bellabeat Leaf Retention Analysis - Visualization Script
# Author: Davon Mendoza
# Purpose: Visualize behavioral differences across retention segments
# Tools: R, ggplot2, tidyverse
# Dataset Source: BigQuery aggregated results
# -----------------------------------------------------------


# -----------------------------------------------------------
# 1. Load Required Libraries
# -----------------------------------------------------------

# tidyverse contains ggplot2, dplyr, readr and other useful packages
library(tidyverse)

# readr is used for importing CSV files
library(readr)

# ggplot2 is used for creating data visualizations
library(ggplot2)

# dplyr is used for data manipulation
library(dplyr)


# -----------------------------------------------------------
# 2. Import the Dataset
# -----------------------------------------------------------

# Load the exported CSV file from BigQuery analysis
# This dataset contains aggregated behavioral metrics by retention segment

retention_behavior <- read_csv("retention_behavior_analysis.csv")


# Inspect dataset structure
# This helps verify column names and data types
glimpse(retention_behavior)



# -----------------------------------------------------------
# 3. Ensure Logical Ordering of Retention Segments
# -----------------------------------------------------------

# Convert retention_segment into an ordered factor
# This ensures charts appear in logical order instead of alphabetical order

retention_behavior$retention_segment <- factor(
  retention_behavior$retention_segment,
  levels = c(
    "High Consistency",
    "Moderate Consistency",
    "Low Consistency"
  )
)



# -----------------------------------------------------------
# 4. Chart 1: User Distribution by Retention Segment
# -----------------------------------------------------------

# Show how many users belong to each engagement segment.
# This helps stakeholders understand the scale of each group.

segment_distribution_chart <- ggplot(
  retention_behavior,
  aes(x = retention_segment, y = users_in_segment)
) +
  
  # Create bar chart
  geom_bar(stat = "identity", fill = "darkorange") +
  
  # Add data labels above bars
  geom_text(
    aes(label = users_in_segment),
    vjust = -0.3,
    size = 5
  ) +
  
  labs(
    title = "User Distribution by Retention Segment",
    x = "Retention Segment",
    y = "Number of Users"
  ) +
  
  theme_minimal()

# Display chart
segment_distribution_chart



# -----------------------------------------------------------
# 5. Chart 2: Average Daily Steps by Retention Segment
# -----------------------------------------------------------

# Purpose:
# Compare daily movement levels across engagement groups

steps_chart <- ggplot(
  retention_behavior,
  aes(x = retention_segment, y = avg_steps)
) +
  
  geom_bar(stat = "identity", fill = "steelblue") +
  
  # Display step values above bars
  geom_text(
    aes(label = round(avg_steps,0)),
    vjust = -0.3
  ) +
  
  labs(
    title = "Average Daily Steps by Retention Segment",
    x = "Retention Segment",
    y = "Average Steps"
  ) +
  
  theme_minimal()

steps_chart



# -----------------------------------------------------------
# 6. Chart 3: Average Sedentary Minutes by Retention Segment
# -----------------------------------------------------------

# Purpose:
# Identify which user groups spend the most time inactive

sedentary_chart <- ggplot(
  retention_behavior,
  aes(x = retention_segment, y = avg_sedentary_minutes)
) +
  
  geom_bar(stat = "identity", fill = "tomato") +
  
  geom_text(
    aes(label = round(avg_sedentary_minutes,0)),
    vjust = -0.3
  ) +
  
  labs(
    title = "Average Sedentary Minutes by Retention Segment",
    x = "Retention Segment",
    y = "Average Sedentary Minutes"
  ) +
  
  theme_minimal()

sedentary_chart



# -----------------------------------------------------------
# 7. Chart 4: Average Active Minutes by Retention Segment
# -----------------------------------------------------------

# Purpose:
# Compare exercise intensity levels across user segments

active_minutes_chart <- ggplot(
  retention_behavior,
  aes(x = retention_segment, y = avg_active_minutes)
) +
  
  geom_bar(stat = "identity", fill = "seagreen") +
  
  geom_text(
    aes(label = round(avg_active_minutes,0)),
    vjust = -0.3
  ) +
  
  labs(
    title = "Average Active Minutes by Retention Segment",
    x = "Retention Segment",
    y = "Average Active Minutes"
  ) +
  
  theme_minimal()

active_minutes_chart



# -----------------------------------------------------------
# 8. Chart 4: Sleep Records Coverage by Retention Segment
# -----------------------------------------------------------

# Purpose:
# Identify how much sleep data exists for each segment.
# This helps explain missing values in sleep efficiency.

sleep_chart <- ggplot(
  retention_behavior,
  aes(x = retention_segment, y = sleep_record_count)
) +
  
  geom_bar(stat = "identity", fill = "purple") +
  
  geom_text(
    aes(label = sleep_record_count),
    vjust = -0.3
  ) +
  
  labs(
    title = "Sleep Records Coverage by Retention Segment",
    x = "Retention Segment",
    y = "Number of Sleep Records"
  ) +
  
  theme_minimal()

sleep_chart



# -----------------------------------------------------------
# 9. Export Charts for Portfolio / GitHub
# -----------------------------------------------------------

# Save charts as PNG files
# These images can be uploaded to the GitHub "charts" folder

ggsave(
  "segment_distribution_chart.png",
  segment_distribution_chart,
  width = 8,
  height = 5
)

ggsave(
  "avg_steps_chart.png",
  steps_chart,
  width = 8,
  height = 5
)

ggsave(
  "sedentary_minutes_chart.png",
  sedentary_chart,
  width = 8,
  height = 5
)

ggsave(
  "active_minutes_chart.png",
  active_minutes_chart,
  width = 8,
  height = 5
)

ggsave(
  "sleep_records_chart.png",
  sleep_chart,
  width = 8,
  height = 5
)