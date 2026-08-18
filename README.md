# 🏦 Bank Customer Churn Analysis

An end-to-end analysis of credit card customer churn — combining **Python** for data cleaning and exploration, **SQL** for structured querying, and **Power BI** for interactive visualization.

---

## 📌 Project Overview

Banks lose significant revenue when customers close their credit card accounts. This project explores the **BankChurners** dataset to understand *who* churns and *why*, using three complementary tools across the analytics workflow:

| Stage | Tool | What it does |
|---|---|---|
| Data Cleaning & EDA | Python (Pandas) | Cleans raw data, engineers features (`Age_Group`, `Churn_Flag`), explores patterns |
| Structured Querying | SQL | 25+ queries from beginner to advanced (aggregation, window functions, subqueries) |
| Visualization | Power BI | Interactive dashboard for churn rate, demographics, and credit behavior |

---

## 📂 Repository Structure

```
bank-churn-analysis/
├── data/
│   └── BankChurners_Cleaned.csv      # Cleaned dataset used across SQL/Python/Power BI
├── python/
│   └── churn_analysis.ipynb          # Data cleaning + exploratory data analysis
├── sql/
│   └── bankchurners_query.sql        # 25+ SQL queries (beginner → advanced)
├── powerbi/
│   └── BankChurnAnalysis.pbix        # Interactive Power BI dashboard
└── README.md
```

---

## 🧹 Data Cleaning (Python)

Using the raw `BankChurners.csv`, the notebook:
- Checks for nulls and duplicates
- Drops irrelevant Naive Bayes classifier columns bundled in the original dataset
- Renames columns for clarity (`Customer_Age` → `Age`, `Income_Category` → `Income_Group`, `Total_Trans_Ct` → `Transaction_Count`)
- Maps `Gender` codes to full labels (`M`/`F` → `Male`/`Female`)
- Engineers new features:
  - `Age_Group` — Young / Adult / Senior
  - `Churn_Flag` — binary 0/1 version of `Attrition_Flag`
- Exports the cleaned dataset for use in SQL and Power BI

## 📊 Exploratory Data Analysis (Python)

Key questions explored in the notebook:
- What % of customers have churned?
- How does churn rate differ by gender?
- What's the average age, credit limit, and transaction behavior by segment?
- Which customers show high transaction activity?

## 🗄️ SQL Analysis

25+ queries covering three difficulty levels:
- **Beginner** — SELECT, WHERE, ORDER BY, DISTINCT, basic aggregates
- **Intermediate** — GROUP BY/HAVING, CASE logic, churn-rate calculations, subqueries
- **Advanced** — Window functions (`RANK`, `DENSE_RANK`, `ROW_NUMBER`), correlated subqueries, per-group comparisons

See [`sql/bankchurners_query.sql`](sql/bankchurners_query.sql) for the full list.

## 📈 Power BI Dashboard

Interactive dashboard covering:
- Overall churn rate and customer counts
- Churn breakdown by gender, income group, and card category
- Credit limit and utilization patterns
- Filterable by age group, education level, and marital status

*(Add a screenshot of your dashboard here — see below)*

---

## 🖼️ Dashboard Preview

> Add a screenshot: export a PNG from Power BI (File → Export → Image) and save it as `powerbi/dashboard_preview.png`, then reference it here:
>
> `![Dashboard Preview](powerbi/dashboard_preview.png)`

---

## 🛠️ Tools Used

- **Python:** Pandas, NumPy, Matplotlib
- **SQL:** Standard ANSI SQL (window functions, subqueries, aggregation)
- **Power BI:** Interactive dashboard and DAX measures

---

## 🚀 How to Use

1. **Python:** Open `python/churn_analysis.ipynb` in Jupyter or VS Code and run all cells.
2. **SQL:** Load `data/BankChurners_Cleaned.csv` into your database, then run `sql/bankchurners_query.sql`.
3. **Power BI:** Open `powerbi/BankChurnAnalysis.pbix` in Power BI Desktop.

---

## 📎 Dataset Source

Based on the publicly available **BankChurners** credit card customer dataset.
