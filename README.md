# Indian-FinTech-UPI-Analysis
Digital Financial Inclusion &amp; UPI Transaction Analysis in India

# 📊 UPI Payment Optimization & Fraud Risk Analysis

## 🚀 Project Overview
This project focuses on analyzing digital payment transactions in India to improve UPI performance, detect fraud patterns, and enhance user experience. The analysis is inspired by real-world fintech platforms.

---

## 🎯 Business Objectives
- Improve transaction success rate
- Identify high-risk and fraudulent transactions
- Analyze user behavior and payment trends
- Optimize UPI app performance

---

## 🧾 Dataset Description
The dataset contains 1000+ transactions with the following fields:
- transaction_id
- user_id
- state
- upi_app
- amount
- transaction_date
- failure_status
- is_government_payment
- device_type
- internet_type

---

## 🧠 Key SQL Analysis

### 1. UPI App Success Rate
```sql
SELECT upi_app,
ROUND(SUM(CASE WHEN failure_status='Success' THEN 1 ELSE 0 END)*100.0 / COUNT(*),2) AS success_rate
FROM fintech
GROUP BY upi_app
ORDER BY success_rate DESC;
```

### 2. State-wise Failure Rate
```sql
SELECT state,
ROUND(SUM(CASE WHEN failure_status='Failed' THEN 1 ELSE 0 END)*100.0 / COUNT(*),2) AS failure_rate
FROM fintech
GROUP BY state
ORDER BY failure_rate DESC;
```

### 3. High-Risk Transactions
```sql
SELECT *
FROM fintech
WHERE failure_status='Failed'
AND amount > 3000;
```

### 4. App-wise Revenue Contribution
```sql
SELECT upi_app, SUM(amount) AS total_value
FROM fintech
GROUP BY upi_app
ORDER BY total_value DESC;
```

### 5. Internet Impact on Failures
```sql
SELECT internet_type,
COUNT(*) AS total,
SUM(CASE WHEN failure_status='Failed' THEN 1 ELSE 0 END) AS failed_count
FROM fintech
GROUP BY internet_type;
```

---

## 📊 Key Insights
- Mobile-based transactions dominate digital payments
- Certain states show higher failure rates due to network issues
- Government payments contribute significantly to total transactions
- High-value failed transactions may indicate fraud patterns

---

## 💡 Business Recommendations
- Improve infrastructure in high-failure regions
- Optimize apps for low network conditions
- Implement fraud detection systems
- Focus on mobile-first user experience

---

## 🔮 Future Scope
- AI-based fraud detection model
- Real-time analytics dashboard
- Predictive transaction analysis

---

## 👤 Author
**Vedant Prajapati**  
📧 Prajapativedant908@gmail.com  
📞 9601533689  
📍 Ahmedabad  
💼 Domain: FinTech
