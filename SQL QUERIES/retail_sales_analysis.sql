-- ============================================
-- SUPERSTORE SALES ANALYSIS PROJECT
-- ============================================
-- ============================================
-- 1. SALES ANALYSIS
-- ============================================

-- 1.1 Total Revenue 
-- Why: Gives overall business size — starting point for any analysis

select round(sum(Sales),2) as total_sales
from train;

-- 1.2 Top 10 Products by Sales
-- Why: Identifies best-selling products to focus inventory/marketing

select Product_Name ,round(sum(Sales),2) as total_sales 
from train 
group by Product_Name
order by total_sales desc limit 10;

-- 1.3 Average Order value 
-- Why: Shows typical spend per order — useful for setting sales targets

select round(avg(order_totals),2) as avg_order_value 
from(
select Order_ID , sum(Sales) as order_totals
from train 
group by Order_ID)
as total_orders;


/*
-- firstly fixed the Order_Date (text) to Order_Date_fixed (date)
set sql_safe_updates = 0;

update train set Order_Date_fixed = str_to_date(Order_Date, '%d-%m-%Y');

set sql_safe_updates = 1;

select Order_Date , Order_Date_fixed from train limit 10;

select month(Order_Date_fixed) from train;
*/
-- ============================================
-- 1.4 Monthly Sales Trend 
-- Why: Reveals seasonality and growth/decline patterns over time

select date_format(Order_Date_fixed , '%Y-%m') as month ,
round(sum(Sales),2) as total_sales  
from train
group by date_format(Order_Date_fixed , '%Y-%m')
order by month desc ;

-- ============================================
-- 2. CUSTOMER ANALYSIS
-- ============================================
-- 2.1 Top 5 Cities by Sales 
-- Why: Helps identify high-performing markets for targeted campaigns

select City , round(sum(Sales),0) as total_sales
from train
group by City
order by total_sales desc  limit 5;

-- 2.2 Segment-wise Sales + Percentage of Total Sales
-- Why: Shows which customer segment drives most revenue

select Segment , round(sum(Sales),2) as total_sales,
round(
 sum(Sales) * 100 / ( select sum(Sales) from train),2)
 as sales_percentage
from train group by Segment 
order by total_sales desc;

-- 2.3 Top 10 Customers by revenue
-- Why: Identifies high-value customers for retention focus

select Customer_ID, Customer_Name , round(sum(Sales),2) as total_revenue 
from train
group by  Customer_ID, Customer_name 
order by total_revenue desc limit 10 ;

-- 2.4 Top Customers by number of orders 
-- Why: Highlights most frequent buyers, different from highest spenders

select  Customer_ID, Customer_Name , count(distinct(Order_ID)) as total_orders
from train
group by Customer_ID, Customer_Name 
order by total_orders desc limit 10;

-- 2.5 Top Customers by average order value
-- Why: Finds customers who spend big per order — good for premium offers

select Customer_ID, Customer_Name, round(avg(order_total), 2) as avg_order_value
from 
(select Customer_ID, Customer_Name, Order_ID, sum(Sales) as order_total
from train
group by Customer_ID, Customer_Name, Order_ID
) as order_level
group by Customer_ID, Customer_Name
order by avg_order_value desc
limit 10;
-- ============================================
-- 3. SHIPPING ANALYSIS
-- ============================================
-- firstly fix Ship_date (text) to Ship_date (date) 
alter table train add column Ship_Date_fixed DATE;

SET SQL_SAFE_UPDATES = 0; 

UPDATE train set Ship_Date_fixed = str_to_date(Ship_Date,'%d-%m-%Y'); 

SET SQL_SAFE_UPDATES = 1; 

select  Ship_Date, Ship_Date_fixed
from train limit 10;
-- ============================================
-- 3.1 Average Shipping Time 
-- Why: Measures overall delivery speed — key for customer satisfaction

select round(avg(datediff(Ship_Date_fixed , Order_Date_fixed)),2) 
as avg_shipping_period
from train ;

-- 3.2 Shipping time varies across different shipping service levels
-- Why: Compares delivery speed across service levels to spot slow modes

select Ship_Mode , round(avg(datediff(Ship_Date_fixed , Order_Date_fixed)),1)
as avg_shipping_time
from train 
group by Ship_mode
order by avg_shipping_time desc ;

-- 3.3 Revenue across different shipping service levels
-- Why: Shows which shipping option customers prefer to pay for

select Ship_Mode ,round(sum(Sales),2) as total_revenue
from train 
group by Ship_Mode
order by total_revenue desc;

-- 3.4 Number of Orders by Shipping Mode
-- Why: Shows popularity of each shipping option

select Ship_Mode ,count(distinct(Order_ID)) as total_orders
from train 
group by Ship_Mode
order by total_orders desc;

-- 3.5 average sales by shipping levels
-- Why: Checks if certain shipping modes are linked with bigger orders

select Ship_Mode ,round(avg(Sales),2) as avg_sales
from train 
group by Ship_Mode
order by avg_sales desc;

-- ============================================
-- 4. PRODUCT ANALYSIS
-- ============================================

-- 4.1 Category-wise Sales & Sales Contribution
-- Why: Shows which product category drives most of the business

select Category , round(sum(Sales),2) as total_revenue ,
round(sum(Sales) * 100 / (select sum(Sales) from train),2)
as Sales_percentage
from train 
group by Category 
order by total_revenue desc ;

-- 4.2 Top Sub-Categories by Sales & Sales Contribution
-- Why: Drills deeper into category to find specific strong sub-categories

select Sub_Category , round(sum(Sales),2) as total_revenue ,
round(sum(Sales) * 100 / (select sum(Sales) from train),2)
as Sales_percentage
from train 
group by Sub_Category 
order by total_revenue desc ;

-- 4.3 Top 10 Products by Category
-- Why: Finds the top 10 best-selling products within each category

select Category, Product_Name,total_revenue, product_rank
from 
(select Category,Product_Name, round(sum(Sales),2) as total_revenue, 
row_number() over (partition by Category order by sum(Sales) desc ) as product_rank
 from train
group by Category, Product_Name) as ranked_products
where product_rank <= 10
order by Category, product_rank;

-- ============================================
-- 5. GEOGRAPHICAL ANALYSIS
-- ============================================

-- 5.1 Total Sales by States
-- Why: Identifies strongest and weakest states for regional strategy

select State , round(sum(Sales),2) as total_sales 
from train 
group by State 
order by total_sales
desc ;

-- 5.2 Total Sales by Cities
-- Why: More granular view than state — useful for local marketing

select City ,round(sum(Sales),2) as total_sales
from train 
group by City 
order by total_sales
desc ; 

-- 5.3 Yearly Sales by State
-- Why: Tracks how each state's performance changes year over year

select State , 
year(Order_Date_fixed) as Year ,
round(sum(Sales),2) as total_sales 
from train
group by State , year(Order_Date_fixed)
order by  State , Year desc ;

-- 5.4  YOY Sales Growth
-- Why: Measures business growth rate year-on-year

with yearly_sales as 
(select year(Order_Date_fixed) as year,
sum(Sales) as total_sales
from train 
group by year(Order_Date_fixed)
) 

select year , 
round(total_sales,2) as Total_Sales , 
lag (Total_Sales) over(order by year) as  previous_year_sales , 
round(
(Total_Sales - lag (Total_Sales) over(order by year))
 / lag (Total_Sales) over(order by year) *100 ,2)
as yoy_growth_percentage
from yearly_sales
order by year;

-- ============================================
-- 6. RANKING ANALYSIS (RANK / DENSE_RANK)
-- ============================================

-- 6.1 Top 3 Products by Sales within each Category
-- Why: Finds category-wise bestsellers instead of overall bestsellers only

select * from (
select Category , Product_Name , round(sum(Sales),2) as total_sales,
rank() over(partition by Category order by sum(Sales) desc) as sales_rank
from train
group by Category , Product_Name) as ranked
 where sales_rank <= 3 
 order by Category , sales_rank;
 
 -- 6.2 Top Sub-Category by Sales within each Category (best performer per Category)
 -- Why: Highlights the single strongest sub-category driving each category's sales

select * from 
(
select Category , Sub_Category , round(sum(Sales),0) as total_sales,
dense_rank() over(partition by Category order by sum(Sales) desc) as sales_rank
from train
group by Category , Sub_Category )
 as top_ranked
where sales_rank =1 
order by total_sales desc;

-- 6.3 Top States by Sales within each Region 
-- Why: Finds best-performing states within each region for regional targeting

with top_states as
 (
  select Region , State ,round(sum(Sales),2) as total_sales,
  rank() over(partition by Region order by sum(Sales) desc) as state_rank
  from train
  group by State ,Region)
  
  select * from top_states 
  where state_rank <=3
order by Region , state_rank;

-- 6.4 Rank Customers by Revenue within each Segment (top 5 per Segment)
-- Why: Identifies key accounts within each customer segment

with cte as (

select Segment , Customer_Name , Customer_ID,
round(sum(Sales),2) as total_revenue,
dense_rank() over(partition by Segment order by sum(Sales) desc) as customer_rank
from train
group by Segment , Customer_ID, Customer_Name)

select * from cte 
where customer_rank <= 5 
order by  Segment, customer_rank;

-- 6.5 Rank months by sales within each Year (best month per year)
-- Why: Finds peak sales month every year — useful for planning promotions/stock

with BEST_MONTH as 
(
select year(Order_Date_fixed) as year,
monthname(Order_Date_fixed) as name_of_month,
round(sum(Sales),1) as total_sales,
dense_rank() over (partition by year(Order_Date_fixed) order by sum(Sales) desc) as month_rank
from train 
group by year(Order_Date_fixed) , 
monthname(Order_Date_fixed))

select * from BEST_MONTH 
where month_rank = 1
order by year;

-- ============================================

















