SELECT  
  COUNT(*) AS row_count,
  MIN(order_date) AS earliest_order,
  MAX(order_date) AS latest_order
FROM `superstore-project-490512.superstore_data.prepared` 