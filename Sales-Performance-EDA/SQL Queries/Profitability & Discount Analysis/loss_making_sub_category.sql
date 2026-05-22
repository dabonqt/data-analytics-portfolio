/* This is to determine and rank the top 3
  products that bleeds the superstore the most */
  
WITH sub_category_performance AS (
  SELECT
  sub_category,
  category,
  COUNT(*) AS order_count,
  ROUND(SUM(sales),4) AS total_sales,
  ROUND(SUM(profit),4) AS total_profit,
  ROUND(SAFE_DIVIDE(SUM(profit),
        SUM(sales)),4) AS overall_margin,
  ROUND(AVG(discount),4) AS avg_discount
FROM `superstore-project-490512.superstore_data.prepared`
GROUP BY sub_category, category

)

SELECT
  *,
  RANK() OVER(ORDER BY total_profit ASC) AS loss_rank
FROM sub_category_performance
WHERE total_profit < 0
ORDER BY total_profit ASC
