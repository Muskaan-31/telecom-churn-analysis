# Telco Customer Churn Analysis
### End-to-End Churn Intelligence — Python EDA | MySQL | Power BI
### 7,043 Customers | 51 Features | $139K Monthly Revenue at Risk Quantified

![Python](https://img.shields.io/badge/Python-3.10+-blue?logo=python)
![MySQL](https://img.shields.io/badge/MySQL-8.0-orange?logo=mysql)
![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow?logo=powerbi)
![pandas](https://img.shields.io/badge/pandas-2.0-green?logo=pandas)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
## Overview

This project identifies the drivers of customer churn at a telecom company
and quantifies the revenue impact — across three tools used in a real
analyst workflow: Python for EDA, MySQL for business queries, and Power BI
for dashboard reporting.

**The central business question:** Which customers are most likely to churn,
why are they churning, and what is it costing the business per month?

**Dataset:** IBM Telco Customer Churn dataset — 7,043 customers,
51 attributes covering demographics, services, contract type,
billing, satisfaction scores, and churn reason.
## Key Findings

| Finding | Number |
|---|---|
| Overall churn rate | 26.5% (1,869 of 7,043 customers) |
| Monthly revenue at risk from churned customers | **$139,130/month** |
| Month-to-Month contract churn rate | **45.8%** |
| Two-Year contract churn rate | **2.5%** |
| Churn rate for customers under 12 months tenure | **48.3%** |
| Churn rate without Online Security | 31.3% vs 14.6% with it |
| Avg monthly charge of churned customers | $74.44 |
| Avg satisfaction score of churned customers | 1.74 / 5.0 |

> **The single highest-leverage intervention:** Customers on Month-to-Month
> contracts with tenure < 12 months churn at 18x the rate of Two-Year
> contract customers. Targeting this segment with a contract upgrade offer
> or a free add-on (Online Security / Tech Support) addresses the majority
> of churn risk.
## Project Structure

### Tool 1 — Python EDA (`Notebooks/02_EDA_Churn_Analysis.ipynb`)
- Null imputation: `Offer` → 'No Offer', `Internet Type` → 'No Internet',
  `Churn Category/Reason` → 'No churn' (no rows dropped)
- Churn_Flag encoding: 'Yes'→1, 'No'→0 for numeric analysis
- 5 analysis charts: churn rate, contract type breakdown, tenure
  distribution, charges boxplots, correlation heatmap
- Service analysis: customers without Online Security churn at 2.14x
  the rate of those with it

### Tool 2 — MySQL (`sql/churntelco.sql`)
- 6 business queries executed in MySQL Workbench
- Revenue at risk quantification: $139,130/month
- Payment method analysis for high-risk segment
  (Month-to-Month + tenure < 12 months)
- Window function: RANK() OVER for highest-value churned customers

### Tool 3 — Power BI (`dashboard/dashboard.pbix`)
- Interactive single-page dashboard
- Slicers: Contract type, tenure range, churn status
- Visuals: churn rate KPIs, contract breakdown bar chart,
  tenure line chart, payment method analysis
## EDA Charts

### Overall Churn Rate
<img width="607" height="641" alt="01_overall_churn_rate" src="https://github.com/user-attachments/assets/9ca9715d-0d6d-494f-ad88-0b50e8f2ead1" />

### Churn Rate by Contract Type
<img width="1029" height="704" alt="02_churn_by_contract" src="https://github.com/user-attachments/assets/0abedaa8-9e25-43b6-af22-02a6ebd970a3" />

### Churn Distribution by Customer Tenure
<img width="1275" height="704" alt="03_churn_by_tenure" src="https://github.com/user-attachments/assets/5a14db48-e6c7-43b5-b661-fdffac63e9ad" />

### Monthly & Total Charges vs Churn
<img width="2084" height="731" alt="04_charges_vs_churn" src="https://github.com/user-attachments/assets/fd7b623b-5238-4086-980f-5aa5cfdb4485" />

### Correlation Heatmap — Numeric Features
<img width="955" height="790" alt="05_correlation_heatmap" src="https://github.com/user-attachments/assets/2260675b-472e-416d-9ae9-4faeee81f894" />

## SQL Analysis Highlights

```sql
-- Monthly revenue at risk from churned customers
SELECT
    ROUND(SUM(`Monthly Charge`), 2)  AS monthly_revenue_at_risk,
    COUNT(*)                          AS churned_customers,
    ROUND(AVG(`Monthly Charge`), 2)  AS avg_monthly_charge_churned
FROM telco
WHERE `Churn Label` = 1;
-- Result: $139,130.85 | 1,869 customers | $74.44 avg

-- High-risk segment: payment method breakdown
-- (Month-to-Month + tenure < 12 months)
SELECT `Payment Method`, COUNT(*) AS total,
       SUM(`Churn Label`) AS churned,
       ROUND(SUM(`Churn Label`) * 100.0 / COUNT(*), 2) AS churn_pct
FROM telco
WHERE `Tenure in Months` < 12 AND Contract = 'Month-to-month'
GROUP BY `Payment Method` ORDER BY churn_pct DESC;
-- Result: Mailed Check 65.5% | Bank Withdrawal 64.8% | Credit Card 32.9%
## Tech Stack

| Tool | Usage |
|---|---|
| Python 3.10 | pandas, numpy, matplotlib, seaborn, scikit-learn |
| MySQL 8.0 | Business queries, window functions, revenue analysis |
| Power BI | Interactive dashboard with slicers and KPI cards |
| Jupyter Notebook | Analysis environment |
| MySQL Workbench | SQL execution and result verification |
## How to Run

**Python EDA:**
```bash
pip install pandas numpy matplotlib seaborn scikit-learn
jupyter notebook notebooks/02_EDA_Churn_Analysis.ipynb
```

**SQL:**
```sql
-- Import telco.csv into MySQL as table 'telco' in schema 'churn_db'
-- Then run queries in sql/churntelco.sql
```

**Power BI:**
```
Open dashboard/dashboard.pbix in Power BI Desktop
Reconnect data source to your local telco.csv path
```
## Business Recommendation

Based on this analysis, three interventions address 80% of churn risk:

1. **Contract migration campaign** — Target all 3,610 Month-to-Month
   customers with a discounted One-Year contract offer. Even converting
   20% would prevent ~149 churns/month worth ~$11K in monthly revenue.

2. **First-year retention program** — Customers with tenure < 12 months
   churn at 48.3%. A free 3-month Online Security add-on for new customers
   directly addresses the 2x churn differential for unprotected accounts.

3. **Payment method incentive** — Mailed Check users in the high-risk
   segment churn at 65.5% vs 32.9% for Credit Card users. A switch
   incentive (one-month credit) could reduce churn in this group by ~30%.
