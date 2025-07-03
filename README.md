##  Overview


This project demonstrates my ability to extract, transform, and load (ETL) real-world business data for end-to-end analysis and visualization. It showcases the full data analysis pipeline — from raw data extraction to insight-driven dashboards.
---


##  Dataset Description

A Domino's Pizza sales dataset consisting of four related tables:

| Table Name        | Description                                |
|------------------|--------------------------------------------|
| **orders.csv**         | Order ID, date, and time details.            |
| **order_details.csv**  | Items and quantities in each order.         |
| **pizzas.csv**         | Pizza details — type, size, price.          |
| **pizza_types.csv**    | Pizza names and categories (Veg, Chicken, etc.). |

---


** Some Key Insights
1. Cumulative Revenue Over Time.
2. Least Selling Pizzas.
3. Best Selling Pizzas.
4. Low-Quantity but High-Revenue Pizzas.
5. Peak Ordering Hour.
6. Top Revenue Pizzas in Each Category.

 **SQL script available in Pizza_Sales_Analysis.sql.**

---

##  Tableau Dashboard Highlights

✔Fully interactive, filter-driven dashboard covering:

| Insight                                  | Visualization |
|-----------------------------------------|--------------|
| **Total Sales, Total Revenue, AOV**      | KPI Cards    |
| **Revenue by Pizza Category**            | Pie Chart    |
| **Revenue by Pizza Size**                | Pie Chart    |
| **Top 5 Best-Selling Pizzas**            | Bar Chart    |
| **Low Quantity but High Revenue Pizzas** | Scatter Plot |
| **Peak Sales Hours**                     | Line Chart   |
| **Cumulative Revenue Trend**             | Line Chart   |

###  **Filters Applied (Globally Connected):**
- **Size**
- **Category**
- **Date Range**

**Interactive Tableau Dashboard: Pizza_Sales_Dashboard.twbx.**

---

##  Key Insights Discovered

-  **Classic Deluxe Pizza** among top revenue contributors.
-  Peak Sales Hours: **12 PM - 2 PM & 7 PM - 9 PM**.
-  Some pizzas generate high revenue despite low sales volume — hidden profit makers.
-  Cumulative revenue shows consistent growth — no severe dips.
-  Medium-sized pizzas dominate total revenue share.

---

##  Tools & Technologies Used

- **SQL (MySQL Workbench)** — Data Extraction, Transformation, Querying
- **Tableau Public/Desktop** — Dashboard Building & Visualization
- **Excel/CSV Files** — Raw Data Source
- ETL Process — End-to-end flow of Extract → Transform → Load followed to build a complete analysis pipeline.

---




