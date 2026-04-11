
CREATE OR REPLACE VIEW `superstore-project-490512.superstore_data.prepared` AS

SELECT
  `Order Date` AS order_date,
  `Ship Date` AS ship_date,
  `Row ID` AS row_id,
  `Order ID` AS order_id,
  `Customer ID` AS customer_id,
  `Customer Name` AS customer_name,
  `Ship Mode` AS ship_mode,
  `Sub-Category` As sub_category,
  `Postal Code` AS postal_code,
  `Product ID` AS product_id,
  `Product Name` AS product_name,

  Sales AS sales,
  Profit AS profit,
  Discount AS discount,
  SAFE_DIVIDE(Profit,Sales) AS profit_margin,
  Category AS category,
  Region AS region,
  Segment AS segment,
  Country AS country,
  City AS city,
  State AS state,
  Quantity AS quantity 


FROM `superstore-project-490512.superstore_data.sales` 