# Olist Commerce Store Data Analysis

## Introduction
Olist Commerce Store seeks to gain a deeper understanding of their business performance and customer behavior through comprehensive data analysis. The primary objective of this analysis is to identify trends, patterns, and actionable insights that can help optimize marketing strategies, improve customer satisfaction, and enhance overall operational efficiency.

## Analysis Objectives
To achieve these goals, the following key questions were addressed:

- What are the trends in order volumes over different time periods?
- Which days of the week and times of the day see the highest and lowest order volumes?
- What is the geographical distribution of orders across Brazilian states and cities?
- How do payment methods vary among customers and over time?
- What are the delivery performance metrics across different regions?

## Dataset Structure

The Olist Commerce Store dataset is organized into several interconnected tables as shown in the following diagram:

![Dataset Structure](https://github.com/user-attachments/assets/6257c643-91b0-49ee-a75e-c5e52339d33a)

## Business Relevant Metrics & Dimensions

### Metrics
- **Total Orders**: The count of all orders placed.
- **Orders by Time Period**: The total orders placed each month, week, and time of day.
- **Order Percentage by State**: The percentage distribution of total orders across different states.
- **Total Amount Sold (R$)**: The total sales revenue generated.
- **Average Delivery Time**: The average number of days taken for delivery.
- **Difference Between Estimated and Actual Delivery Time**: The difference in days between the estimated and actual delivery times.

### Dimensions
- **Time (Year-Month, Day of the Week, Time of Day)**: Specific time periods when orders were placed.
- **Geography (State, City)**: The location where orders were placed.
- **Payment Method**: The type of payment method used (e.g., credit card, debit card, boleto, voucher).

## Insights Summary

### Order Trends

- **Monthly Trends**: Significant fluctuations in order volumes were observed, with notable peaks during promotional periods such as Black Friday, where order volumes surged by approximately 30% compared to other months.
- **Weekly and Daily Trends**: Mondays had the highest order volumes, with a 5% increase compared to the weekly average, while Saturdays had the lowest at 8% below the average. The most popular times for placing orders were during the afternoon (38.6%) and night (34.3%).

### Geographical Distribution

- **State and City Distribution**: São Paulo accounted for 42.5% of total orders, followed by Rio de Janeiro at 13.1%. São Paulo city alone had the highest number of orders among all cities, contributing significantly to the state's dominance.

### Payment Methods

- **Payment Method Preferences**: Credit cards were the most preferred payment method, accounting for 74% of transactions, followed by boletos at 19%. The usage of credit cards showed an increasing trend over time, with a 10% growth from the beginning to the end of the observed period.

### Delivery Performance

- **Average Delivery Time**: The average delivery time across all orders was 13 working days, with significant variation across different states, ranging from 9 days in São Paulo to 29 days in Roraima.
- **Delivery Accuracy**: The average difference between estimated and actual delivery times was -11 days, indicating that deliveries were generally completed 11 days faster than estimated, highlighting efficiency in the logistics process.


## Recommendations
- **Enhance Marketing Strategies**: Focus marketing efforts on high-performing days (e.g., Mondays) and peak times (afternoon and night) to maximize order volumes.
- **Optimize Regional Operations**: Allocate resources and optimize logistics for high-order regions like São Paulo and Rio de Janeiro to improve efficiency.
- **Improve Payment Options**: Ensure robust support for popular payment methods like credit cards and explore opportunities to promote alternative methods to balance payment processing loads.
- **Streamline Delivery Processes**: Investigate states with longer delivery times and work on improving logistics to reduce delivery times further. Additionally, maintain the accuracy of delivery estimates to manage customer expectations better.

## Dashboard
The dashboard can be found in Tableau Public [here](https://public.tableau.com/app/profile/oussama.ziane/viz/OlistE-Commerce_16992851459070/EVOLDWEEKTDAY2). This dashboard allows users to analyze order trends, geographical distribution, payment methods, and delivery performance by filtering data across time periods and regions.

![Dashboard Image](https://github.com/user-attachments/assets/fd8033c0-b273-4c6f-bcc5-68899469cd1e)
