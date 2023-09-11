--Sergio Zapico, September 11 2023

--Finding Total Revenue: The Sum of all Pizza orders
Select Sum(total_price) As Total_Revenue
From pizza_sales

--Finding Average Amount spent per Order: Divide Total Revenue/ Total number of Orders
Select Sum(total_price)/Count(Distinct order_id) As Avg_Order_Value
From pizza_sales

--Total Pizzas Sold
Select Sum(quantity) as Total_Pizza_Sold
From pizza_sales

--Finding the Total orders placed
Select Count(Distinct order_id) as Total_Orders
From pizza_sales

--Average Pizzas Per Order
Select Cast(Cast(Sum(quantity) as Decimal(10,2)) / Cast(Count(Distinct order_id) as Decimal (10,2)) as Decimal (10,2)) As Avg_Pizza_Per_Order
From pizza_sales

--Hourly Trend for Total Pizzas Sold
Select DatePart(Hour, order_time) as Order_hour, Sum(quantity) as Total_Pizzas_Sold
From pizza_sales
Group By DatePart(Hour, order_time)
Order By DatePart(Hour, order_time)

----Weekly Trend for Total Orders
Select DATEPART(Iso_Week, order_date) as Week_Number, Year(order_date) as Order_Year, Count(Distinct order_id) as Total_Orders
From pizza_sales
Group By DATEPART(Iso_Week, order_date),Year(order_date)
Order By DATEPART(Iso_Week, order_date), Year(order_date)



-- % of Sales by Pizza Category
Select pizza_category, sum(total_price) as Total_Sales,sum(total_price) * 100 / (Select sum(total_price) from pizza_sales Where Month(order_date) = 1) AS PCT_Total_Sales
from pizza_sales 
Where Month(order_date) = 1
Group By  pizza_category

-- % of Sales by Pizza Size
Select pizza_size, Cast(sum(total_price) As Decimal (10,2)) as Total_Sales,Cast(sum(total_price) * 100 / (Select sum(total_price) from pizza_sales where datepart(quarter, order_date)=1) AS Decimal(10,2)) AS PCT_Total_Sales
from pizza_sales
Where DatePart(quarter, order_date)=1
Group By  pizza_size
Order By PCT_Total_Sales DESC

--Top 5 Pizzas by Revenue
Select TOP 5 pizza_name, Sum(total_price) AS Total_Revenue from pizza_sales
Group By pizza_name
Order By Total_Revenue desc

-- Bottom 5 Pizzas by Revenue
Select TOP 5 pizza_name, Sum(total_price) AS Total_Revenue from pizza_sales
Group By pizza_name
Order By Total_Revenue ASC

--Top 5 Pizzas by Quantity 
Select TOP 5 pizza_name, Sum(quantity) AS Total_Quantity from pizza_sales
Group By pizza_name
Order By Total_Quantity DESC

--Top 5 Pizzas by Total Orders
SELECT Top 5 pizza_name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Orders DESC
