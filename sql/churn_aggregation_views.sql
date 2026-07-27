CREATE VIEW vw_churn_by_contract AS
SELECT 
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS churn_rate
FROM telco_churn_cleaned
GROUP BY Contract;

SELECT * FROM vw_churn_by_contract;

CREATE VIEW vw_revenue_risk_by_cltv AS
SELECT 
    CLTV_Tier,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    CAST(SUM(CASE WHEN Churn_Label = 'Yes' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*) AS churn_rate,
    SUM(CASE WHEN Churn_Label = 'Yes' THEN Monthly_Charges ELSE 0 END) AS monthly_revenue_at_risk
FROM telco_churn_cleaned
GROUP BY CLTV_Tier;

SELECT * FROM vw_revenue_risk_by_cltv;

CREATE VIEW vw_reason_by_cltv_tier AS
SELECT 
    CLTV_Tier,
    Reason_Category,
    COUNT(*) AS customer_count
FROM telco_churn_cleaned
WHERE Churn_Label = 'Yes'
GROUP BY CLTV_Tier, Reason_Category;

SELECT * FROM vw_reason_by_cltv_tier ORDER BY CLTV_Tier, customer_count DESC;