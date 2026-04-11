/*This is to get the monthly growth trend from
  previous sales and profit*/

WITH monthly_trend AS(

  SELECT
    DATE_TRUNC(order_date, MONTH) AS month,
    ROUND(SUM(sales),4) AS monthly_sales,
    ROUND(SUM(profit),4)  AS monthly_profit
  FROM `superstore-project-490512.superstore_data.prepared`
  GROUP BY 1
),

monthly_with_lag AS(
    SELECT
      *,
    LAG(monthly_sales) OVER (ORDER BY month) AS prev_month_sales,
    LAG(monthly_profit) OVER (ORDER BY month) AS prev_month_profit
    FROM monthly_trend
  )

SELECT
  *,
  ROUND(SAFE_DIVIDE(monthly_sales - prev_month_sales, prev_month_sales),4)
    AS monthly_sales_growth,
  ROUND(SAFE_DIVIDE(monthly_profit - prev_month_profit,prev_month_profit),4)
    AS monthly_profit_growth
FROM monthly_with_lag
