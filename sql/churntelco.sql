CREATE DATABASE churn_db;
USE churn_db;
SELECT COUNT(*) FROM telco;
SELECT COUNT(*) AS total_customers,
    SUM(`Churn Label`) AS churned,
    ROUND(SUM(`Churn Label`) * 100.0 / COUNT(*), 2) AS churn_rate_pct
FROM telco;
SELECT 
    Contract,
    COUNT(*) AS total,
    SUM(`Churn Label`) AS churned,
    ROUND(SUM(`Churn Label`) * 100.0 / COUNT(*), 2) AS churn_pct
FROM telco
GROUP BY Contract
ORDER BY churn_pct DESC;
SELECT 
    ROUND(SUM(`Monthly Charge`), 2) AS monthly_revenue_at_risk,
    COUNT(*) AS churned_customers,
    ROUND(AVG(`Monthly Charge`), 2) AS avg_monthly_charge_churned
FROM telco
WHERE `Churn Label` = 1;
SELECT 
    `Payment Method`,
    COUNT(*) AS total,
    SUM(`Churn Label`) AS churned,
    ROUND(SUM(`Churn Label`) * 100.0 / COUNT(*), 2) AS churn_pct
FROM telco
WHERE `Tenure in Months` < 12 
  AND Contract = 'Month-to-month'
GROUP BY `Payment Method`
ORDER BY churn_pct DESC;
SHOW COLUMNS FROM telco;
SELECT 
    `Monthly Charge`,
    `Tenure in Months`,
    Contract,
    RANK() OVER (ORDER BY `Monthly Charge` DESC) AS revenue_rank
FROM telco
WHERE `Churn Label` = 1
LIMIT 20;
