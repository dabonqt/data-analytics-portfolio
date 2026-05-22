-- Category-level discount concentration and profit impact

SELECT
  category,
  discount_tier,
  ROUND(SUM(profit), 4) AS total_profit,
  ROUND(AVG(profit_margin),4) AS avg_profit_margin,
  MAX(category_total_orders) AS category_total_orders,
  ROUND(COUNT(*) / 
    MAX(category_total_orders),4) AS percent_of_category_orders
FROM (
  SELECT *,
  CASE
    WHEN discount = 0     THEN 'No Discount'
    WHEN discount <= 0.2  THEN 'Low (0-20%)'
    WHEN discount <= 0.3  THEN 'Medium (21-30%)'
    ELSE 'High (30%+)'
    END AS discount_tier,
    COUNT(*) OVER (PARTITION BY category) AS category_total_orders
  FROM `superstore-project-490512.superstore_data.prepared`
 )
GROUP BY category, discount_tier
ORDER BY avg_profit_margin ASC
