/* This is to compare the category performance
  based on revenue vs. profit */

WITH revenue_vs_profit AS(
SELECT
  category,
  ROUND(SUM(sales),4) AS total_sales,
  ROUND(SUM(profit),4) AS total_profit,
  ROUND(SAFE_DIVIDE(
    SUM(profit), SUM(sales)),4)
      AS category_margin
FROM superstore_data.prepared
GROUP BY category
)

SELECT
  *,
  RANK() OVER (ORDER BY total_sales DESC) AS rank_in_sales,
  RANK() OVER (ORDER BY total_profit DESC) AS rank_in_profit,
  ROUND(SAFE_DIVIDE(
    total_sales, SUM(total_sales) OVER()),4) AS share_of_total_sales,
  ROUND(SAFE_DIVIDE(
    total_profit, SUM(total_profit) OVER()),4) AS share_of_total_profit
FROM revenue_vs_profit