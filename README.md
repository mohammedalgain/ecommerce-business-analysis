# E-Commerce — Business Analysis

SQL and Python analysis of the [Olist Brazilian E-Commerce dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce), answering three business questions using a relational SQLite database.

## Business Questions

1. Which product categories generate the most revenue, and how has revenue trended month over month?
2. Who are the top sellers by revenue, and how does order volume relate to revenue?
3. Do best-selling products also have the best review scores?

## Key Findings

- **Revenue** is concentrated in health & beauty, gifts/watches, and home categories. Platform revenue grew steadily through 2017, peaking in November 2017 (likely Black Friday). The final month in the dataset shows an apparent drop — this reflects incomplete data at the extraction cutoff, not an actual decline.
- **Sellers** reach the top 10 by revenue via different strategies — some through high order volume at lower prices, others through fewer, higher-priced sales.
- **Product reviews** show no strong relationship with sales volume — best-selling products aren't necessarily the best-reviewed ones.

## Tools & Approach

- **SQLite** (via DB Browser for SQLite) — loaded the 9 raw Olist CSVs into a relational database and wrote the core business-question queries (joins, aggregations, subqueries).
- **Python** (`pandas`, `matplotlib`, `seaborn`) — reused the validated SQL queries via `pd.read_sql()` and added visualizations (bar charts, line chart, scatter plot).

## Files

| File | Description |
|---|---|
| `olist_analysis.ipynb` | Full analysis notebook — SQL queries run from Python, with charts and written findings |
| `queries.sql` | The core SQL queries on their own, with comments |
| `olist_ecommerce.db` | SQLite database (see note below) |

## Data Quality Note

While building this analysis, I found that a small number of orders had more than one review record attached in the raw data. I verified this didn't meaningfully skew the results, but corrected for it in the product-vs-reviews query using a subquery that pre-aggregates reviews to one row per order before joining.

## Setup

1. Download the dataset from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) if rebuilding the database from scratch, or use the included `olist_ecommerce.db`.
2. `pip install pandas matplotlib seaborn`
3. Open `olist_analysis.ipynb` in Jupyter and run all cells (make sure `olist_ecommerce.db` is in the same folder).

## Dataset

[Olist Brazilian E-Commerce Public Dataset](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) on Kaggle — ~100k orders from a Brazilian e-commerce marketplace, split across 9 relational tables (orders, customers, products, sellers, reviews, payments, etc.).
