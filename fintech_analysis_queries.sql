-- =========================================================
-- 📌 Project: Indian FinTech UPI Data Analysis
-- 📊 File: fintech_analysis_queries.sql
-- 🧑‍💻 Description:
-- This file contains SQL queries for analyzing digital 
-- payment transactions related to UPI and financial inclusion.
-- =========================================================


-- =========================================================
-- 🔹 Q1: Total Number of Transactions
-- Objective: Count all transactions in the dataset
-- =========================================================
SELECT COUNT(*) AS total_transactions 
FROM fintech;


-- =========================================================
-- 🔹 Q2: Total Transaction Amount
-- Objective: Calculate total value of all transactions
-- =========================================================
SELECT SUM(amount) AS total_value 
FROM fintech;


-- =========================================================
-- 🔹 Q3: State-wise Transaction Count
-- Objective: Identify which states have highest transactions
-- =========================================================
SELECT state, COUNT(*) AS total_transactions
FROM fintech
GROUP BY state
ORDER BY total_transactions DESC;


-- =========================================================
-- 🔹 Q4: Most Used UPI Application
-- Objective: Find the most popular UPI app
-- =========================================================
SELECT upi_app, COUNT(*) AS usage_count
FROM fintech
GROUP BY upi_app
ORDER BY usage_count DESC;


-- =========================================================
-- 🔹 Q5: Government Payment Percentage
-- Objective: Calculate % of transactions from govt schemes
-- =========================================================
SELECT 
    (SUM(CASE 
            WHEN is_government_payment = 'Yes' THEN 1 
            ELSE 0 
         END) * 100.0) / COUNT(*) AS govt_payment_percentage
FROM fintech;


-- =========================================================
-- 🔹 Q6: Transaction Failure Rate
-- Objective: Measure system performance using failure %
-- =========================================================
SELECT 
    (SUM(CASE 
            WHEN failure_status = 'Failed' THEN 1 
            ELSE 0 
         END) * 100.0) / COUNT(*) AS failure_rate_percentage
FROM fintech;


-- =========================================================
-- 🔹 Q7: Account Type Usage (Jan Dhan vs Others)
-- Objective: Analyze financial inclusion via account types
-- =========================================================
SELECT account_type, COUNT(*) AS total_users
FROM fintech
GROUP BY account_type
ORDER BY total_users DESC;


-- =========================================================
-- 🔹 Q8: Gender-based Transaction Analysis
-- Objective: Compare transaction value by gender
-- =========================================================
SELECT gender, SUM(amount) AS total_transaction_value
FROM fintech
GROUP BY gender
ORDER BY total_transaction_value DESC;


-- =========================================================
-- 🔹 Q9: Monthly Transaction Trend
-- Objective: Analyze transaction trends over months
-- =========================================================
SELECT 
    MONTH(transaction_date) AS transaction_month,
    SUM(amount) AS monthly_total
FROM fintech
GROUP BY MONTH(transaction_date)
ORDER BY transaction_month;


-- =========================================================
-- 🔹 Q10: Average Transaction per UPI App
-- Objective: Measure average spending per app
-- =========================================================
SELECT upi_app, AVG(amount) AS avg_transaction_value
FROM fintech
GROUP BY upi_app
ORDER BY avg_transaction_value DESC;


-- =========================================================
-- ✅ End of SQL File
-- =========================================================