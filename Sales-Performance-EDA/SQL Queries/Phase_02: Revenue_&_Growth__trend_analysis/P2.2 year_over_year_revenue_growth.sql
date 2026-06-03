/*This is to get the annual growth trend from
  previous sales and profit*/

WITH yearly_trend AS(
  SELECT
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(SUM(sales),4) AS annual_sales,
    ROUND(SUM(profit),4) AS annual_profit
  FROM `superstore-project-490512.superstore_data.prepared`
  GROUP BY 1
),

annual_with_lag AS(
  SELECT
    *,
  LAG(annual_sales) OVER (ORDER BY year) AS prev_year_sales,
  LAG(annual_profit) OVER (ORDER BY year) AS prev_year_profit
  FROM yearly_trend
)

  SELECT
    *,
  ROUND(SAFE_DIVIDE(
    annual_sales - prev_year_sales, prev_year_sales), 4) 
    AS annual_sales_growth,

  ROUND(SAFE_DIVIDE(
    annual_profit - prev_year_profit, prev_year_profit), 4)
    AS annual_profit_growth

FROM annual_with_lag