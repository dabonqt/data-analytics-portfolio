/* Determine which region generates the most revenue
  & most profitable, then rank them along with their
  rank gap. */

WITH region_profit_and_sales AS(
  SELECT
    region,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales),2) AS total_sales,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(SAFE_DIVIDE(
      SUM(profit), SUM(sales)
      ),4) AS profit_margin,
    ROUND(AVG(discount),4) AS avg_discount
  FROM `superstore-project-490512.superstore_data.prepared`
  GROUP BY region
)

SELECT
  *,
  RANK() OVER (ORDER BY total_sales DESC) AS rank_in_sales,
  RANK() OVER (ORDER BY total_profit DESC) AS rank_in_profit,
  ABS(
    RANK() OVER (ORDER BY total_sales DESC) -
    RANK() OVER (ORDER BY total_profit DESC)
    ) AS rank_gap
FROM region_profit_and_sales
