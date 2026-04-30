/* This is to determine if there is
  a region x segment combination that is
  particularly underpeforming */

WITH region_and_segment AS
(SELECT
  
  region,
  segment,
  ROUND(SUM(sales),4) AS total_sales,
  ROUND(SUM(profit),4) AS total_profit,
  ROUND(SAFE_DIVIDE(
    SUM(profit), SUM(sales)
      ),4) AS profit_margin,
  ROUND(AVG(discount),4) AS avg_discount

FROM `superstore-project-490512.superstore_data.prepared`
GROUP BY 1,2
)

SELECT
  *,
  DENSE_RANK() OVER (PARTITION BY region ORDER BY profit_margin ASC) AS margin_rank_in_region
FROM region_and_segment
ORDER BY region, margin_rank_in_region