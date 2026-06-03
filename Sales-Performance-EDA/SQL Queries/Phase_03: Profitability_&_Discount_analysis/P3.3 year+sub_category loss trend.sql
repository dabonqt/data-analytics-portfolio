/* Drill-down from P3.2: tracks how losses in Tables, Bookcases,
   and Supplies trended year over year from 2011 to 2014 */

SELECT
 EXTRACT(YEAR FROM order_date) AS year,
 sub_category,
 ROUND(SUM(profit), 4) AS annual_profit,
 ROUND(AVG(discount), 4) AS avg_discount,
 COUNT(*) AS order_count
FROM `superstore-project-490512.superstore_data.prepared`
WHERE sub_category IN ('Supplies','Bookcases', 'Tables')
GROUP BY year, sub_category
ORDER BY sub_category, year
