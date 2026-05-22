/* This is to determine which customer segment 
  is most valuable in profit, not just in sales
  volume. */

WITH customer_profit_and_sales AS
  (SELECT
    segment AS customer_segment,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales),4) AS total_sales,
    ROUND(SUM(profit),4) AS total_profit,
    ROUND(SAFE_DIVIDE(
    SUM(profit), SUM(sales)
      ),4) AS profit_margin,
    ROUND(AVG(discount),4) AS avg_discount
  FROM `superstore-project-490512.superstore_data.prepared`
  GROUP BY segment
)
SELECT
  *,
  RANK() OVER (ORDER BY total_sales DESC) AS rank_in_sales,
  RANK() OVER (ORDER BY total_profit DESC) AS rank_in_profit,
  ABS(
    RANK() OVER (ORDER BY total_sales DESC) -
    RANK() OVER (ORDER BY total_profit DESC)
  ) AS rank_gap
FROM customer_profit_and_sales

