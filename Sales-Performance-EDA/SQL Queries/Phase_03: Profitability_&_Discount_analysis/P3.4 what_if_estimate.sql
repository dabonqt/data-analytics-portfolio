/*This is the "what-if" estimate on high
  discount orders if they could've been
  broke even*/

SELECT
COUNT(*) AS affected_order_count,
SUM(profit) AS actual_profit_from_high_discount_orders,
ROUND(ABS(SUM(profit)),2) AS recoverable_profit,
ROUND((SELECT SUM(profit)
       FROM`superstore_data.prepared`),2)
       AS total_company_profit
FROM`superstore-project-490512.superstore_data.prepared`
WHERE discount > 0.3