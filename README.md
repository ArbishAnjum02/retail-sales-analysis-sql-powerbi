# Superstore Retail Sales Analysis & Power BI Dashboard

> A complete end-to-end data analytics project examining retail store performance across sales, customer segments, product categories, shipping methods, and

regional growth.

---



## 📌 Table of Contents

- [Overview](#overview)
- [Problem Statement](#problem-statement)
- [Dataset](#dataset)
- [Tools & Technologies](#tools-technologies)
- [Project Structure](#project-structure)
- [Methods & Analysis](#methods-analysis)
- [Key Insights](#key-insights)
- [Dashboard & Output](#dashboard-output)
- [How to Run This Project](#how-to-run-this-project)
- [Results & Conclusion](#results-conclusion)
- [Future Work](#future-work)
- [Author & Contact](#author-contact)

---
<a id="overview"></a>

## 📌 Overview

**This project provides an end-to-end evaluation of retail business performance. Using SQL for data transformation, cleaning, and querying alongside Power BI
for interactive visualization, this project transforms raw transactional data into actionable business recommendations for store managers and executives.**

---
<a id="problem-statement"></a>

## 🎯 Problem Statement

**Retail stores process large volumes of order data daily, but raw numbers make it hard to spot revenue opportunities or logistical bottlenecks. Key challenges
addressed in this project include:**

- Identifying top revenue drivers across product categories and customer segments.

- Evaluating Year-over-Year (YoY) sales growth and monthly seasonal patterns.

- Assessing shipping efficiency and its impact on revenue delivery.

- Identifying high-value customers and key geographic markets.

---
<a id="dataset"></a>

## 📊 Dataset

- **Primary Data Source:** ``train.csv`` (Superstore Transactional Sales Dataset)

- **Key Fields:** ``Order_ID`` , ``Order_Date`` , ``Ship_Date`` , ``Ship_Mode`` , ``Customer_ID ``, ``Customer_Name`` , ``Segment`` , ``City`` , ``State`` , ``Region`` , ``Category`` , ``Sub_Category`` ,
``Product_Name`` ,`` Sales``.

---
<a id="tools-technologies"></a>
## 🛠️ Tools & Technologies

- **Database Querying:** MySQL / SQL Server (SQL window functions, CTEs, aggregation, date parsing)

- **Data Visualization:** Power BI Desktop ( .pbix report)

- **Version Control:** Git & GitHub

---
<a id="project-structure"></a>

## 📁Project Structure





```text

superstore-sales-analysis/

│

├── README.md # Project documentation

├── retail_sales_analysis.sql # Complete SQL script with query analyses

├── sales_superstore_project 1.pbix # Interactive Power BI Report

└── assets/

└── dashboard.png # Dashboard preview screenshot

```



---
<a id="methods-analysis"></a>

## 🔍Methods & Analysis

The data analysis in MySQL ( retail_sales_analysis.sql ) is structured into 6 main modules:

1. **Sales Performance:** Total revenue, top 10 products, average order value (AOV), and monthly trends.



2. **Customer Analytics:** Segment sales breakdown, top revenue customers, frequent order counts, and AOV per customer.

3. **Logistics & Shipping:** Date conversions, average delivery times by shipping mode, and preferred ship modes.

4. **Product Analysis:** Category/Sub-category contributions and top products ranked within categories.

5. **Geographical & Growth Analysis:** State/city sales metrics and Year-over-Year (YoY) growth calculations using window functions.

6. **Advanced Ranking:** Using RANK() and DENSE_RANK() to isolate regional top performers, best customer accounts per segment, and peak revenue months per year.

---
<a id="key-insights"></a>


## 💡 Key Insights

- **YoY Growth & Seasonality**: Peak sales consistently occur during Q4, showing strong end-of-year seasonal purchasing patterns.

- **Category Leadership:** A small group of high-value product categories drives the majority of store revenue.

- **Customer Segmentation:** Core customer segments contribute disproportionately to total sales, highlighting top target accounts for loyalty incentives.

- **Logistics Efficiency:** Standard class shipping handles the largest volume of orders, while expedited shipping modes show distinct order size trends.

---
<a id="dashboard-output"></a>

## 🖥️ Dashboard & Output

The interactive Power BI dashboard provides key executive visuals:

- Executive KPI Cards (Total Sales, Average Order Value, Order Volume)

- Monthly Sales Trends & YoY Growth Charts

- Regional & State Sales Heatmaps

- Category & Sub-Category Breakdown Bar Charts

![Superstore Sales Dashboard](assets/dashboard.png)

---
<a id="how-to-run-this-project"></a>

## 🚀How to Run This Project

1. **Clone the repository:**

```bash

git clone https://github.com/your-username/superstore-sales-analysis.git

```

2. **Run the SQL queries:**

- Import train.csv into your MySQL database workspace.

- Open and execute retail_sales_analysis.sql step-by-step to generate sales summary metrics and ranking tables.





3. **Open the Power BI Dashboard:**

- Install Power BI Desktop.

- Open sales_superstore_project 1.pbix to view and interact with the visualizations.

---
<a id="results-conclusion"></a>

## 🏁 Results & Conclusion

**This project demonstrates how raw transactional sales data can be converted into clear strategic insights. By combining structured SQL queries with clear
Power BI visualizations, business stakeholders can quickly identify growth areas, streamline shipping modes, and focus on high-value customer segments.**

---
<a id="future-work"></a>

## 🔮 Future Work

- Build a predictive forecasting model to estimate future quarterly sales.

- Incorporate profitability and margin data to analyze cost structures alongside revenue.

- Implement automated ETL pipelines to pull daily transactional updates.

---
<a id="author-contact"></a>

## ✍️Author & Contact

- **Author: [Arbish Anjum]**

- **LinkedIn: [Your LinkedIn Profile URL]**

- **GitHub: [Your GitHub Profile URL]**

- **Email: [arbishanjum547@gmail.com]**

