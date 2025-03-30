📊 Real-Time COVID-19 Data Analysis using SQL

📌 Overview

This project analyzes real-time COVID-19 data using SQL to extract meaningful insights into case trends, mortality rates, and vaccination progress across different countries and continents. The dataset includes information on COVID-19 cases, deaths, vaccinations, and population statistics.

🛠️ Features & Insights

1️⃣ Data Exploration & Cleaning

✔ Extract relevant data from coviddeaths and covidvaccinations tables.
✔ Filter out null values for accurate analysis.

2️⃣ COVID-19 Case & Mortality Analysis

📌 Calculate infection rate relative to the population.
📌 Determine likelihood of death for infected individuals.
📌 Identify countries with the highest death and infection rates.
📌 Analyze death counts per continent.

3️⃣ Global COVID-19 Trends

📊 Aggregate global cases, deaths, and mortality rates over time.

4️⃣ Vaccination Progress Analysis

💉 Compare vaccination numbers vs. population.
💉 Use window functions to calculate rolling vaccination counts.
💉 Implement CTEs (Common Table Expressions) for structured queries.
💉 Store insights in temporary tables & views for easy visualization.

🚀 Technologies Used
	•	SQL – Querying and analyzing COVID-19 data.
	•	Window Functions – Rolling calculations for vaccination data.
	•	CTEs & Temp Tables – Structured and reusable query methods.
	•	Views – Precomputed data for visualization.

📈 How to Use This Project
	1.	Ensure the coviddeaths and covidvaccinations datasets are available in your SQL database.
	2.	Run the provided SQL queries in sequence to generate insights.
	3.	Modify queries as needed to focus on specific regions, timeframes, or variables.
	4.	Use the stored views for data visualization in Tableau, Power BI, or Excel.

🚀 Future Improvements

✅ Time-series analysis to track COVID-19 waves.
✅ Geospatial visualizations of infection & vaccination rates.
✅ Machine learning models for trend prediction.
