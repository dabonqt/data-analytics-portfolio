/* Thid is to identify which calendar month performs best on average
across all four years combined*/

SELECT

  EXTRACT(MONTH FROM order_date) AS calendar_month,
  COUNT(DISTINCT DATE_TRUNC(order_date, YEAR)) AS years_in_data,
  ROUND(SUM(sales),4) AS total_sales,
  ROUND(SUM(profit),4) AS total_profit,
  ROUND(AVG(sales),4) AS avg_order_value,
  ROUND(SUM(sales) / COUNT(DISTINCT DATE_TRUNC(order_date, YEAR)), 2)
    AS avg_annual_sales_for_month

FROM `superstore-project-490512.superstore_data.prepared`
GROUP BY 1
ORDER BY 1