-- =========================================================
-- 📌 Project: Indian FinTech Advanced SQL Analysis
-- 📊 File: Advance_analysis.sql
-- 🧑‍💻 Description:
-- Contains 100+ advanced SQL queries for deep analysis
-- including aggregations, window functions, subqueries,
-- case statements, and business insights.
-- =========================================================


-- =========================================================
-- 🔹 SECTION 1: BASIC + AGGREGATION (1–15)
-- =========================================================

-- Q1: Total Transactions
SELECT COUNT(*) FROM fintech;

-- Q2: Total Transaction Value
SELECT SUM(amount) FROM fintech;

-- Q3: Average Transaction Value
SELECT AVG(amount) FROM fintech;

-- Q4: Maximum Transaction
SELECT MAX(amount) FROM fintech;

-- Q5: Minimum Transaction
SELECT MIN(amount) FROM fintech;

-- Q6: Count per State
SELECT state, COUNT(*) FROM fintech GROUP BY state;

-- Q7: Total Value per State
SELECT state, SUM(amount) FROM fintech GROUP BY state;

-- Q8: Transactions per App
SELECT upi_app, COUNT(*) FROM fintech GROUP BY upi_app;

-- Q9: Avg Amount per App
SELECT upi_app, AVG(amount) FROM fintech GROUP BY upi_app;

-- Q10: Gender Count
SELECT gender, COUNT(*) FROM fintech GROUP BY gender;

-- Q11: Account Type Distribution
SELECT account_type, COUNT(*) FROM fintech GROUP BY account_type;

-- Q12: Govt vs Private Count
SELECT is_government_payment, COUNT(*) FROM fintech GROUP BY is_government_payment;

-- Q13: Success vs Failed
SELECT failure_status, COUNT(*) FROM fintech GROUP BY failure_status;

-- Q14: Monthly Transactions
SELECT MONTH(transaction_date), COUNT(*) 
FROM fintech GROUP BY MONTH(transaction_date);

-- Q15: Monthly Value
SELECT MONTH(transaction_date), SUM(amount)
FROM fintech GROUP BY MONTH(transaction_date);


-- =========================================================
-- 🔹 SECTION 2: FILTERING + CONDITIONS (16–30)
-- =========================================================

-- Q16: High Value Transactions (>5000)
SELECT * FROM fintech WHERE amount > 5000;

-- Q17: Failed Transactions
SELECT * FROM fintech WHERE failure_status='Failed';

-- Q18: Govt Payments Only
SELECT * FROM fintech WHERE is_government_payment='Yes';

-- Q19: Jan Dhan Users Only
SELECT * FROM fintech WHERE account_type='JanDhan';

-- Q20: Female Users Transactions
SELECT * FROM fintech WHERE gender='Female';

-- Q21: Urban Transactions
SELECT * FROM fintech WHERE location_type='Urban';

-- Q22: Rural Transactions
SELECT * FROM fintech WHERE location_type='Rural';

-- Q23: Transactions in Gujarat
SELECT * FROM fintech WHERE state='Gujarat';

-- Q24: Transactions using Google Pay
SELECT * FROM fintech WHERE upi_app='Google Pay';

-- Q25: Amount Between 1000–5000
SELECT * FROM fintech WHERE amount BETWEEN 1000 AND 5000;

-- Q26: Not Failed Transactions
SELECT * FROM fintech WHERE failure_status!='Failed';

-- Q27: Multiple Conditions
SELECT * FROM fintech 
WHERE gender='Male' AND amount > 2000;

-- Q28: OR Condition
SELECT * FROM fintech 
WHERE state='Maharashtra' OR state='Delhi';

-- Q29: Govt + High Value
SELECT * FROM fintech 
WHERE is_government_payment='Yes' AND amount > 3000;

-- Q30: Recent Transactions
SELECT * FROM fintech 
WHERE transaction_date > '2024-01-01';


-- =========================================================
-- 🔹 SECTION 3: CASE STATEMENTS (31–45)
-- =========================================================

-- Q31: Categorize Amount
SELECT amount,
CASE 
  WHEN amount < 1000 THEN 'Low'
  WHEN amount BETWEEN 1000 AND 5000 THEN 'Medium'
  ELSE 'High'
END AS category
FROM fintech;

-- Q32: Fraud Flag
SELECT *,
CASE 
  WHEN failure_status='Failed' THEN 'Risk'
  ELSE 'Safe'
END AS risk_flag
FROM fintech;

-- Q33: Govt Payment Label
SELECT *,
CASE 
  WHEN is_government_payment='Yes' THEN 'Govt'
  ELSE 'Private'
END AS payment_type
FROM fintech;

-- Q34: Gender Label
SELECT *,
CASE 
  WHEN gender='Male' THEN 'M'
  ELSE 'F'
END
FROM fintech;

-- Q35: Account Label
SELECT *,
CASE 
  WHEN account_type='JanDhan' THEN 'Financial Inclusion'
  ELSE 'Regular'
END
FROM fintech;

-- Q36: Transaction Type Based on Amount
SELECT *,
CASE 
  WHEN amount > 5000 THEN 'High Value'
  ELSE 'Normal'
END AS transaction_type
FROM fintech;

-- Q37: Failure Indicator (1 = Failed, 0 = Success)
SELECT *,
CASE 
  WHEN failure_status = 'Failed' THEN 1
  ELSE 0
END AS failure_flag
FROM fintech;

-- Q38: Government Benefit Category
SELECT *,
CASE 
  WHEN is_government_payment = 'Yes' AND amount > 2000 THEN 'High Govt Benefit'
  WHEN is_government_payment = 'Yes' THEN 'Low Govt Benefit'
  ELSE 'Non-Govt'
END AS govt_category
FROM fintech;

-- Q39: Age Group Classification
SELECT *,
CASE 
  WHEN age < 25 THEN 'Youth'
  WHEN age BETWEEN 25 AND 50 THEN 'Adult'
  ELSE 'Senior'
END AS age_group
FROM fintech;

-- Q40: Weekend vs Weekday Transactions
SELECT *,
CASE 
  WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekend'
  ELSE 'Weekday'
END AS day_type
FROM fintech;

-- Q41: High Risk Transactions
SELECT *,
CASE 
  WHEN failure_status='Failed' AND amount > 3000 THEN 'High Risk'
  ELSE 'Low Risk'
END AS risk_level
FROM fintech;

-- Q42: App Popularity Category
SELECT upi_app,
CASE 
  WHEN COUNT(*) > 200 THEN 'Highly Used'
  ELSE 'Less Used'
END AS app_category
FROM fintech
GROUP BY upi_app;

-- Q43: Income Level Approximation
SELECT *,
CASE 
  WHEN amount > 4000 THEN 'High Income'
  WHEN amount BETWEEN 2000 AND 4000 THEN 'Middle Income'
  ELSE 'Low Income'
END AS income_group
FROM fintech;

-- Q44: Success Label
SELECT *,
CASE 
  WHEN failure_status='Success' THEN 'Completed'
  ELSE 'Not Completed'
END AS status_label
FROM fintech;

-- Q45: Urban vs Rural Label
SELECT *,
CASE 
  WHEN location_type='Urban' THEN 'City'
  ELSE 'Village'
END AS location_label
FROM fintech;

-- =========================================================
-- 🔹 SECTION 4: SUBQUERIES (46–60)
-- =========================================================

-- Q46: Above Average Transactions
SELECT * FROM fintech
WHERE amount > (SELECT AVG(amount) FROM fintech);

-- Q47: Highest Transaction
SELECT * FROM fintech
WHERE amount = (SELECT MAX(amount) FROM fintech);

-- Q48: Lowest Transaction
SELECT * FROM fintech
WHERE amount = (SELECT MIN(amount) FROM fintech);

-- Q49: Top State by Transactions
SELECT state FROM fintech
GROUP BY state
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Q50: App with Highest Value
SELECT upi_app FROM fintech
GROUP BY upi_app
ORDER BY SUM(amount) DESC
LIMIT 1;

-- Q51: Users Above Median (approx)
SELECT * FROM fintech
WHERE amount > (
  SELECT AVG(amount) FROM fintech
);

-- Q52: Count Failed Above Avg
SELECT COUNT(*) FROM fintech
WHERE failure_status='Failed'
AND amount > (SELECT AVG(amount) FROM fintech);

-- Q53: Transactions Below Average
SELECT * FROM fintech
WHERE amount < (SELECT AVG(amount) FROM fintech);

-- Q54: State with Lowest Transactions
SELECT state FROM fintech
GROUP BY state
ORDER BY COUNT(*) ASC
LIMIT 1;

-- Q55: App with Lowest Usage
SELECT upi_app FROM fintech
GROUP BY upi_app
ORDER BY COUNT(*) ASC
LIMIT 1;

-- Q56: Transactions Greater than State Avg
SELECT * FROM fintech t
WHERE amount > (
  SELECT AVG(amount)
  FROM fintech
  WHERE state = t.state
);

-- Q57: Users with Above Avg Spending
SELECT customer_id
FROM fintech
GROUP BY customer_id
HAVING SUM(amount) > (
  SELECT AVG(total_spent)
  FROM (
    SELECT customer_id, SUM(amount) AS total_spent
    FROM fintech
    GROUP BY customer_id
  ) t
);

-- Q58: Highest Transaction per State
SELECT * FROM fintech t
WHERE amount = (
  SELECT MAX(amount)
  FROM fintech
  WHERE state = t.state
);

-- Q59: Lowest Transaction per App
SELECT * FROM fintech t
WHERE amount = (
  SELECT MIN(amount)
  FROM fintech
  WHERE upi_app = t.upi_app
);

-- Q60: Above Avg Govt Transactions
SELECT * FROM fintech
WHERE is_government_payment='Yes'
AND amount > (
  SELECT AVG(amount)
  FROM fintech
  WHERE is_government_payment='Yes'
);


-- =========================================================
-- 🔹 SECTION 5: WINDOW FUNCTIONS (61–80)
-- =========================================================

-- Q61: Row Number
SELECT *, ROW_NUMBER() OVER() FROM fintech;

-- Q62: Rank by Amount
SELECT *, RANK() OVER(ORDER BY amount DESC) FROM fintech;

-- Q63: Dense Rank
SELECT *, DENSE_RANK() OVER(ORDER BY amount DESC) FROM fintech;

-- Q64: Partition by State
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY state ORDER BY amount DESC)
FROM fintech;

-- Q65: Running Total
SELECT transaction_date,
SUM(amount) OVER(ORDER BY transaction_date)
FROM fintech;

-- Q66: Moving Avg
SELECT transaction_date,
AVG(amount) OVER(ORDER BY transaction_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
FROM fintech;

-- Q67: Lag Function
SELECT amount,
LAG(amount) OVER(ORDER BY transaction_date)
FROM fintech;

-- Q68: Lead Function
SELECT amount,
LEAD(amount) OVER(ORDER BY transaction_date)
FROM fintech;

-- Q69: Rank per App
SELECT *,
RANK() OVER(PARTITION BY upi_app ORDER BY amount DESC)
FROM fintech;

-- Q70: Top 3 per State
SELECT * FROM (
  SELECT *,
  ROW_NUMBER() OVER(PARTITION BY state ORDER BY amount DESC) rn
  FROM fintech
) t WHERE rn <= 3;

-- Q71: Running Total per State
SELECT state, transaction_date,
SUM(amount) OVER(PARTITION BY state ORDER BY transaction_date)
FROM fintech;

-- Q72: Rank by Amount per Gender
SELECT *,
RANK() OVER(PARTITION BY gender ORDER BY amount DESC)
FROM fintech;

-- Q73: Dense Rank per State
SELECT *,
DENSE_RANK() OVER(PARTITION BY state ORDER BY amount DESC)
FROM fintech;

-- Q74: Avg per State Window
SELECT state,
AVG(amount) OVER(PARTITION BY state)
FROM fintech;

-- Q75: Difference from Previous Transaction
SELECT amount,
amount - LAG(amount) OVER(ORDER BY transaction_date)
FROM fintech;

-- Q76: Next Transaction Difference
SELECT amount,
LEAD(amount) OVER(ORDER BY transaction_date) - amount
FROM fintech;

-- Q77: Cumulative Count
SELECT transaction_date,
COUNT(*) OVER(ORDER BY transaction_date)
FROM fintech;

-- Q78: Percentage Contribution
SELECT amount,
amount*100.0 / SUM(amount) OVER()
FROM fintech;

-- Q79: Top Transaction per App
SELECT * FROM (
  SELECT *,
  ROW_NUMBER() OVER(PARTITION BY upi_app ORDER BY amount DESC) rn
  FROM fintech
) t WHERE rn = 1;

-- Q80: Bottom 3 Transactions per State
SELECT * FROM (
  SELECT *,
  ROW_NUMBER() OVER(PARTITION BY state ORDER BY amount ASC) rn
  FROM fintech
) t WHERE rn <= 3;


-- =========================================================
-- 🔹 SECTION 6: ADVANCED BUSINESS PROBLEMS (81–100)
-- =========================================================

-- Q81: Failure Rate per State
SELECT state,
(SUM(CASE WHEN failure_status='Failed' THEN 1 ELSE 0 END)*100.0)/COUNT(*) AS failure_rate
FROM fintech
GROUP BY state;

-- Q82: Success Rate per App
SELECT upi_app,
(SUM(CASE WHEN failure_status='Success' THEN 1 ELSE 0 END)*100.0)/COUNT(*) 
FROM fintech
GROUP BY upi_app;

-- Q83: Avg per Gender
SELECT gender, AVG(amount)
FROM fintech GROUP BY gender;

-- Q84: Monthly Growth
SELECT MONTH(transaction_date),
SUM(amount)
FROM fintech GROUP BY MONTH(transaction_date);

-- Q85: Top 5 Users by Spending
SELECT customer_id, SUM(amount)
FROM fintech
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;

-- Q86: App Contribution %
SELECT upi_app,
SUM(amount)*100.0/(SELECT SUM(amount) FROM fintech)
FROM fintech GROUP BY upi_app;

-- Q87: Govt Contribution %
SELECT 
SUM(CASE WHEN is_government_payment='Yes' THEN amount ELSE 0 END)*100.0
/ SUM(amount)
FROM fintech;

-- Q88: Rural vs Urban Value
SELECT location_type, SUM(amount)
FROM fintech GROUP BY location_type;

-- Q89: Gender Ratio
SELECT gender, COUNT(*)*100.0/(SELECT COUNT(*) FROM fintech)
FROM fintech GROUP BY gender;

-- Q90: Peak Month
SELECT MONTH(transaction_date)
FROM fintech
GROUP BY MONTH(transaction_date)
ORDER BY SUM(amount) DESC
LIMIT 1;

-- Q91: Avg Govt Transaction Value
SELECT AVG(amount)
FROM fintech
WHERE is_government_payment='Yes';

-- Q92: Avg Private Transaction Value
SELECT AVG(amount)
FROM fintech
WHERE is_government_payment='No';

-- Q93: Failure Count per State
SELECT state, COUNT(*)
FROM fintech
WHERE failure_status='Failed'
GROUP BY state;

-- Q94: Success Count per App
SELECT upi_app, COUNT(*)
FROM fintech
WHERE failure_status='Success'
GROUP BY upi_app;

-- Q95: Top Gender by Spending
SELECT gender
FROM fintech
GROUP BY gender
ORDER BY SUM(amount) DESC
LIMIT 1;

-- Q96: Monthly Avg Transaction
SELECT MONTH(transaction_date), AVG(amount)
FROM fintech
GROUP BY MONTH(transaction_date);

-- Q97: State Contribution %
SELECT state,
SUM(amount)*100.0/(SELECT SUM(amount) FROM fintech)
FROM fintech
GROUP BY state;

-- Q98: High Value Govt Transactions
SELECT * FROM fintech
WHERE is_government_payment='Yes'
AND amount > 4000;

-- Q99: App with Highest Success Rate
SELECT upi_app,
(SUM(CASE WHEN failure_status='Success' THEN 1 ELSE 0 END)*100.0)/COUNT(*) AS success_rate
FROM fintech
GROUP BY upi_app
ORDER BY success_rate DESC
LIMIT 1;

-- Q100: Total Failed Amount
SELECT SUM(amount)
FROM fintech
WHERE failure_status='Failed';


-- =========================================================
-- 🔹 BONUS (101–110)
-- =========================================================

-- Q101: Duplicate Transactions
SELECT transaction_id, COUNT(*)
FROM fintech GROUP BY transaction_id HAVING COUNT(*) > 1;

-- Q102: Null Values Check
SELECT COUNT(*) FROM fintech WHERE amount IS NULL;

-- Q103: Distinct States
SELECT DISTINCT state FROM fintech;

-- Q104: Total Unique Users
SELECT COUNT(DISTINCT customer_id) FROM fintech;

-- Q105: Transactions per Day
SELECT transaction_date, COUNT(*)
FROM fintech GROUP BY transaction_date;

-- Q106: Avg per State
SELECT state, AVG(amount)
FROM fintech GROUP BY state;

-- Q107: High Failure Apps
SELECT upi_app, COUNT(*)
FROM fintech
WHERE failure_status='Failed'
GROUP BY upi_app;

-- Q108: Top State by Value
SELECT state, SUM(amount)
FROM fintech GROUP BY state
ORDER BY SUM(amount) DESC LIMIT 1;

-- Q109: Min Transaction per App
SELECT upi_app, MIN(amount)
FROM fintech GROUP BY upi_app;

-- Q110: Max Transaction per App
SELECT upi_app, MAX(amount)
FROM fintech GROUP BY upi_app;


-- =========================================================
-- ✅ END OF FILE
-- =========================================================