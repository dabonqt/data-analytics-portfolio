/* This is to identify what region performs well
  with the sales but shrinking in profit */

WITH region_sales_trend AS(
SELECT
  EXTRACT(YEAR FROM order_date) AS year,
  region,

  ROUND(SUM(sales),4) AS total_sales,
  ROUND(SUM(profit),4) AS total_profit,
  ROUND(SAFE_DIVIDE(
    SUM(profit), SUM(sales)),4)
      AS profit_margin,
  ROUND(AVG(discount),4) AS avg_discount
FROM `superstore-project-490512.superstore_data.prepared`
GROUP BY 1,2
),

prev_year_sales_and_profit AS(
  SELECT
  *,
  LAG(total_sales) OVER (PARTITION BY region ORDER BY year ASC) AS prev_year_sales,
  LAG(total_profit) OVER (PARTITION BY region ORDER BY year ASC) AS prev_year_profit
FROM region_sales_trend
)

SELECT
  *,
  ROUND(SAFE_DIVIDE(total_sales - prev_year_sales,
    prev_year_sales),4) AS annual_sales_growth,

  ROUND(SAFE_DIVIDE(total_profit - prev_year_profit,
    prev_year_profit),4) AS annual_profit_growth
FROM prev_year_sales_and_profit
ORDER BY region, year