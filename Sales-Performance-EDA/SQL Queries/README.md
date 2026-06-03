# SQL Queries

This folder contains all SQL scripts written in **Google BigQuery** for the Superstore Sales EDA project. Scripts are organized by analytical phase and follow a layered approach, with each phase builds on the outputs of the previous one.

All queries run against the prepared view created in Phase 1. Results were exported as CSV files and connected to Tableau for visualization.

---

## Folder Structure

```
SQL queries/
│
├── Data Preparation & Overview/
│   ├── data_preparation.sql
│   └── data_validation.sql
│
├── Revenue & Growth Trend Analysis/
│   ├── average_annual_sales_for_month.sql
│   ├── month_over_month_revenue_growth_trend.sql
│   └── year_over_year_revenue_growth.sql
│
├── Profitability & Discount Analysis/
│   ├── overall_discount_damage.sql
│   ├── loss_making_sub_category.sql
│   ├── year_subcategory_loss_trend.sql
│   ├── what_if_estimate.sql
│   └── revenue_vs_profit_category_comparison.sql
│
└── Region & Segment Performance Analysis/
    ├── profit_and_sales_per_region.sql
    ├── profit_and_sales_per_customer_segment.sql
    ├── region_segment_performance.sql
    └── region_sales_trend.sql
```

---

## Phase 1 — Data Preparation & Overview

Scripts that establish the analytical foundation. All downstream queries reference the prepared view created here.

### `data_preparation.sql`
Creates the core prepared view from the raw Superstore dataset. Standardizes column names to snake_case, ensures correct date types, and adds a calculated `profit_margin` column using `SAFE_DIVIDE(profit, sales)` to avoid division-by-zero errors.

**Key output:** `superstore_data.prepared` — the single source used by all subsequent scripts.

### `data_validation.sql`
Runs sanity checks against the prepared view to confirm data integrity before analysis. Validates row count (9,994), date range (2011-01-04 to 2014-12-31), NULL counts across all columns, and distinct value verification for Category, Region, and Segment.

**Key output:** Confirms zero NULLs, correct row count, and expected date range.

---

## Phase 2 — Revenue & Growth Trend Analysis

Scripts that establish how the business performs over time — the foundation for understanding why profitability behaves the way it does in Phase 3.

### `average_annual_sales_for_month.sql`
Groups all orders by calendar month number (1–12) across all four years to identify structural seasonal patterns. Uses `COUNT(DISTINCT DATE_TRUNC(order_date, YEAR))` as the denominator to calculate true average annual revenue per calendar month.

**Key finding:** November averages $87,280 in annual revenue, the peak month and 5.8× higher than February's $15,043. Q4 (September–December) consistently drives the highest revenue.

### `month_over_month_revenue_growth_trend.sql`
Uses a CTE to aggregate monthly sales and profit, then applies `LAG()` window functions to calculate month-over-month growth rates for both revenue and profit using `SAFE_DIVIDE()`.

**SQL concepts demonstrated:** CTE chaining, `LAG()` window function, `DATE_TRUNC()`, `SAFE_DIVIDE()`.

**Key finding:** Profit growth is significantly more volatile than sales growth, swinging from +309% to -78% within single months, suggesting high sensitivity to order-level discounting.

### `year_over_year_revenue_growth.sql`
Aggregates annual sales and profit, then applies `LAG()` to calculate year-over-year growth rates for both metrics simultaneously. Uses `EXTRACT(YEAR FROM order_date)` for clean integer year labels.

**SQL concepts demonstrated:** `EXTRACT()`, `LAG()` with `SAFE_DIVIDE()`, dual-metric growth comparison.

**Key finding:** 2014 shows the first year revenue growth (20.6%) outpaced profit growth (14.4%) — the divergence that Phase 3 investigates.

---

## Phase 3 — Profitability & Discount Analysis

The central analytical phase. Six scripts built in three layers — overall damage, sub-category identification, and category-level comparison, culminating in a quantified "what-if" business estimate.

### `overall_discount_damage.sql`
Groups all orders into four discount tiers using `CASE WHEN` and calculates total profit and average profit margin per tier, broken down by category. Uses a subquery to create the tier column before aggregating.

**SQL concepts demonstrated:** `CASE WHEN` grouping, subquery, `AVG()`, `SUM()`, `GROUP BY`.

**Key finding:** All three categories turn loss-making above 30% discount. Office Supplies reaches -122% average margin on high-discount orders — the company spends $2.22 to generate $1.00 in revenue.

### `loss_making_sub_category.sql`
Aggregates profit and sales at the sub-category level, calculates aggregate profit margin using `SAFE_DIVIDE(SUM(profit), SUM(sales))`, then filters using `WHERE total_profit < 0` after aggregation to correctly identify net loss-makers. Uses `RANK()` to order sub-categories from worst to least.

**SQL concepts demonstrated:** Aggregate-level filtering with `WHERE`, `RANK()` window function, `SAFE_DIVIDE()` at group level.

**Key finding:** Tables (-$17,725), Bookcases (-$3,473), and Supplies (-$1,189) are the three loss-making sub-categories — all carrying above-average discount rates.

### `year_subcategory_loss_trend.sql`
Drills into confirmed loss-makers from the previous script and tracks their annual profit and average discount from 2011 to 2014. Scoped explicitly to Tables, Bookcases, and Supplies using `WHERE sub_category IN (...)`.

**SQL concepts demonstrated:** `EXTRACT(YEAR)`, `IN` clause, drill-down scoping from prior analysis.

**Key finding:** Tables losses worsened every year — from -$3,124 in 2011 to -$8,141 in 2014, a 161% deterioration over four years.

### `what_if_estimate.sql`
Calculates the total profit destroyed by orders with discounts exceeding 30% and quantifies the potential recovery if those orders had broken even. Includes total company profit as a reference anchor using a correlated subquery.

**SQL concepts demonstrated:** `WHERE` filter on continuous column, `ABS()`, correlated subquery, `SUM()` for impact quantification.

**Key finding:** 1,166 orders discounted above 30% destroyed $125,007 in profit — equivalent to 43.6% of total company earnings of $286,397.

### `revenue_vs_profit_category_comparison.sql`
Aggregates sales, profit, and margin at the category level. Uses `RANK()` twice — once ordered by sales, once by profit — to surface rank divergence. Uses `SUM() OVER()` with an empty partition to calculate each category's share of company-wide totals.

**SQL concepts demonstrated:** Double `RANK()` window functions, `SUM() OVER()` with empty partition, share-of-total calculation.

**Key finding:** Furniture generates 32.3% of company revenue but only 6.4% of total profit. Technology generates 36.4% of revenue and 50.8% of profit, the company's most efficient category.

---

## Phase 4 — Region & Segment Performance Analysis

Scripts that add geographic and customer-type dimensions to the profitability story established in Phase 3.

### `profit_and_sales_per_region.sql`
Aggregates key metrics by region — order count, total sales, total profit, profit margin, and average discount. Applies double `RANK()` for sales and profit rankings, and `ABS()` of the rank difference to calculate a `rank_gap` score that surfaces revenue-to-profit inconsistency.

**SQL concepts demonstrated:** `COUNT(DISTINCT)`, double `RANK()`, `ABS()` for rank gap calculation.

**Key finding:** Central ranks 3rd in revenue but last in profit with a 7.92% margin — the lowest of all regions. Its 24.04% avg discount is more than double West's 10.93%.

### `profit_and_sales_per_customer_segment.sql`
Same structure as the regional script applied to customer segments — Consumer, Corporate, and Home Office. Includes `rank_gap` for consistency.

**Key finding:** Home Office ranks last in sales volume but carries the highest profit margin at 14.03%. All three segments show nearly identical avg discount rates (14.7–15.8%), confirming over-discounting is company-wide.

### `region_segment_performance.sql`
Creates a 4×3 performance matrix by grouping on both region and segment simultaneously. Uses `DENSE_RANK() OVER (PARTITION BY region ORDER BY profit_margin ASC)` to rank each segment's performance within its own region independently.

**SQL concepts demonstrated:** Multi-column `GROUP BY`, `DENSE_RANK()` with `PARTITION BY`, within-group ranking.

**Key finding:** Central × Consumer is the worst-performing combination at 3.4% profit margin on $252K revenue, driven by a 25.2% avg discount rate.

### `region_sales_trend.sql`
Extends the YoY growth pattern from Phase 2 to the regional level. Uses two chained CTEs — the first aggregates by region and year, the second applies `LAG() OVER (PARTITION BY region ORDER BY year)` to keep each region's timeline independent. The final SELECT calculates growth rates from the named LAG columns.

**SQL concepts demonstrated:** Two-CTE chaining, `LAG()` with `PARTITION BY`, regional year-over-year growth comparison.

**Key finding:** South grew sales 31.5% in 2014 but profit fell 49.9% — the sharpest sales-profit divergence in the dataset. West is the only region to grow both sales (+34.1%) and profit (+83.2%) in 2014.

---

## SQL Concepts Index

| Concept | Scripts where used |
|---|---|
| CTE (`WITH`) | MoM trend, YoY growth, loss-making sub-category, revenue vs profit, all Phase 4 scripts |
| `LAG()` window function | MoM trend, YoY growth, region sales trend |
| `RANK()` / `DENSE_RANK()` | Loss-making sub-category, revenue vs profit, all Phase 4 scripts |
| `PARTITION BY` | Region sales trend, region × segment performance |
| `SAFE_DIVIDE()` | Data preparation, all Phase 3 scripts, all Phase 4 scripts |
| `CASE WHEN` | Overall discount damage |
| `DATE_TRUNC()` | MoM trend, data preparation |
| `EXTRACT()` | YoY growth, year sub-category loss trend, region sales trend |
| `SUM() OVER()` | Revenue vs profit category comparison |
| `ABS()` | What-if estimate, all Phase 4 rank gap calculations |
| `COUNT(DISTINCT)` | All Phase 4 scripts |

