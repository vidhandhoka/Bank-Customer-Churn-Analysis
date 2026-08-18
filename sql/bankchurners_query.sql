-- Q1: View all columns for the first 10 customers
SELECT *
FROM bankchurners.bankchurners_cleaned1
LIMIT 10;

-- Q2: List customer number, age, gender, and income group
SELECT CLIENTNUM, Age, Gender, Income_Group
FROM bankchurners.bankchurners_cleaned1;

-- Q3: Find all customers who have churned (Attrited Customer)
SELECT CLIENTNUM, Age, Gender, Attrition_Flag
FROM bankchurners.bankchurners_cleaned1
WHERE Attrition_Flag = 'Attrited Customer';

-- Q4: Find all customers older than 50
SELECT CLIENTNUM, Age
FROM bankchurners.bankchurners_cleaned1
WHERE Age > 50
ORDER BY Age DESC;

-- Q5: Get the distinct list of card categories offered
SELECT DISTINCT Card_Category
FROM bankchurners.bankchurners_cleaned1;

-- Q6: Get the distinct list of income groups
SELECT DISTINCT Income_Group
FROM bankchurners.bankchurners_cleaned1;

-- Q7: Count the total number of customers
SELECT COUNT(*) AS total_customers
FROM bankchurners.bankchurners_cleaned1;

-- Q8: Count how many customers churned vs existing
SELECT Attrition_Flag, COUNT(*) AS customer_count
FROM bankchurners.bankchurners_cleaned1
GROUP BY Attrition_Flag;

-- Q9: Find the average customer age
SELECT ROUND(AVG(Age), 2) AS avg_age
FROM bankchurners.bankchurners_cleaned1;

-- Q10: List top 10 customers with the highest credit limit
SELECT CLIENTNUM, Credit_Limit
FROM bankchurners.bankchurners_cleaned1
ORDER BY Credit_Limit DESC
LIMIT 10;

-- Q11: Average credit limit by card category
SELECT Card_Category, ROUND(AVG(Credit_Limit), 2) AS avg_credit_limit
FROM bankchurners.bankchurners_cleaned1
GROUP BY Card_Category
ORDER BY avg_credit_limit DESC;

-- Q12: Churn rate (%) by gender
SELECT Gender,
       COUNT(*) AS total_customers,
       SUM(Churn_Flag) AS churned_customers,
       ROUND(100.0 * SUM(Churn_Flag) / COUNT(*), 2) AS churn_rate_pct
FROM bankchurners.bankchurners_cleaned1
GROUP BY Gender;

-- Q13: Churn rate (%) by income group
SELECT Income_Group,
       COUNT(*) AS total_customers,
       ROUND(100.0 * SUM(Churn_Flag) / COUNT(*), 2) AS churn_rate_pct
FROM bankchurners.bankchurners_cleaned1
GROUP BY Income_Group
ORDER BY churn_rate_pct DESC;

-- Q14: Find income groups with more than 1000 customers
SELECT Income_Group, COUNT(*) AS total_customers
FROM bankchurners.bankchurners_cleaned1
GROUP BY Income_Group
HAVING COUNT(*) > 1000;

-- Q15: Categorize customers into utilization buckets using CASE
SELECT CLIENTNUM,
       Avg_Utilization_Ratio,
       CASE
           WHEN Avg_Utilization_Ratio = 0 THEN 'No Utilization'
           WHEN Avg_Utilization_Ratio <= 0.3 THEN 'Low'
           WHEN Avg_Utilization_Ratio <= 0.7 THEN 'Medium'
           ELSE 'High'
       END AS utilization_bucket
FROM bankchurners.bankchurners_cleaned1;

-- Q16: Average months on book and average transaction count by education level
SELECT Education_Level,
       ROUND(AVG(Months_on_book), 1) AS avg_months_on_book,
       ROUND(AVG(Transaction_Count), 1) AS avg_transaction_count
FROM bankchurners.bankchurners_cleaned1
GROUP BY Education_Level
ORDER BY avg_months_on_book DESC;

-- Q17: Find customers whose transaction amount is above the overall average
SELECT CLIENTNUM, Total_Trans_Amt
FROM bankchurners.bankchurners_cleaned1
WHERE Total_Trans_Amt > (SELECT AVG(Total_Trans_Amt) FROM bank_churners)
ORDER BY Total_Trans_Amt DESC;

-- Q18: Find the single customer with the maximum credit limit
SELECT CLIENTNUM, Credit_Limit
FROM bankchurners.bankchurners_cleaned1
WHERE Credit_Limit = (SELECT MAX(Credit_Limit) FROM bank_churners);

-- Q19: Marital status distribution among churned customers only
SELECT Marital_Status, COUNT(*) AS churned_customers
FROM bankchurners.bankchurners_cleaned1
WHERE Attrition_Flag = 'Attrited Customer'
GROUP BY Marital_Status
ORDER BY churned_customers DESC;

-- Q20: Customers inactive for 3+ months with more than 2 contacts in last 12 months
SELECT CLIENTNUM, Months_Inactive_12_mon, Contacts_Count_12_mon, Attrition_Flag
FROM bankchurners.bankchurners_cleaned1
WHERE Months_Inactive_12_mon >= 3
  AND Contacts_Count_12_mon > 2
ORDER BY Months_Inactive_12_mon DESC;

-- Q21: Rank customers by credit limit within each card category
SELECT Card_Category,
        Credit_Limit,
       dense_rank() OVER (PARTITION BY Card_Category ORDER BY Credit_Limit DESC) AS credit_rank
FROM  bankchurners.bankchurners_cleaned1;

-- Q22: Running total of transaction amount ordered by CLIENTNUM
SELECT CLIENTNUM,
       Total_Trans_Amt,
       SUM(Total_Trans_Amt) OVER (ORDER BY CLIENTNUM) AS running_total_trans_amt
FROM bankchurners.bankchurners_cleaned1;

-- Q23: Top 3 customers by transaction amount within each age group
SELECT *
FROM (
    SELECT CLIENTNUM,
           Age_Group,
           Total_Trans_Amt,
           ROW_NUMBER() OVER (PARTITION BY Age_Group ORDER BY Total_Trans_Amt DESC) AS rn
    FROM bankchurners.bankchurners_cleaned1
) ranked
WHERE rn <= 3;

-- Q24: Difference between each customer's credit limit and the average credit limit of their income group
SELECT CLIENTNUM,
       Income_Group,
       Credit_Limit,
       ROUND(Credit_Limit - AVG(Credit_Limit) OVER (PARTITION BY Income_Group), 2) AS diff_from_group_avg
FROM bankchurners.bankchurners_cleaned1;

-- Q25: Find customers whose transaction count is below the average for their own age group
SELECT CLIENTNUM, Age_Group, Transaction_Count
FROM (
    SELECT CLIENTNUM,
           Age_Group,
           Transaction_Count,
           AVG(Transaction_Count) OVER (PARTITION BY Age_Group) AS avg_group_txn
    FROM bankchurners.bankchurners_cleaned1
) t
WHERE Transaction_Count < avg_group_txn
ORDER BY Age_Group;
