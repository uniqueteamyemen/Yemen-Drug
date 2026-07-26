# Market Metrics & KPI Specification
## Yemen Pharmaceutical Market Intelligence Platform

This document defines the Key Performance Indicators (KPIs) and market metrics that the platform will track. These metrics are essential for evaluating the health of the pharmaceutical market and the effectiveness of the intelligence engine, focusing on market visibility and connection rather than transaction processing.

### 1. Product & Market Health Metrics

| Metric Name | Description | Calculation | Target / Threshold |
|-------------|-------------|-------------|--------------------|
| **Most Demanded Drugs** | The drugs (official or free-text) with the highest volume of open requests. | Count of open requests per drug over a specific timeframe. | N/A (Used for ranking) |
| **Highest Surplus Drugs** | The drugs with the highest volume of active offers compared to requests. | Count of active offers minus count of open requests per drug. | N/A (Used for ranking) |
| **Shortage Index** | A normalized score indicating the severity of shortages for a specific drug in a region. | `(Total Demand Weighted / Total Supply Weighted) * 100` | > 100 indicates a shortage |
| **Surplus Index** | A normalized score indicating the severity of surpluses for a specific drug in a region. | `(Total Supply Weighted / Total Demand Weighted) * 100` | > 100 indicates a surplus |
| **Price Volatility Index** | (Future Feature) Measures the fluctuation in reported prices for a drug. | Standard deviation of reported prices over a timeframe. | N/A |

### 2. Platform Efficiency Metrics

| Metric Name | Description | Calculation | Target / Threshold |
|-------------|-------------|-------------|--------------------|
| **Demand Fulfillment Rate** | The percentage of requests that are successfully closed (procured outside the platform). | `(Closed Requests / Total Requests) * 100` | Target: > 70% |
| **Average Time to Fulfill** | The average time taken from request creation to request closure. | `Avg(Closure Time - Creation Time)` | Target: < 48 hours |
| **Offer Expiry Rate** | The percentage of offers that expire without being matched or closed. | `(Expired Offers / Total Offers) * 100` | Target: < 20% |
| **Invisible Inventory Uncovered** | The number of hidden inventory signals successfully converted to active offers. | Count of "Hidden Inventory" signals that led to new offers. | N/A |
| **Connection Success Rate** | The percentage of matched pairs where contact information is successfully revealed. | `(Revealed Contacts / Total Matches) * 100` | Target: > 50% |

### 3. Geographic & Demographic Metrics

| Metric Name | Description | Calculation | Target / Threshold |
|-------------|-------------|-------------|--------------------|
| **Most Deficit Governorates** | Governorates with the highest aggregate Shortage Index. | Sum of Shortage Index across all drugs per governorate. | N/A (Used for ranking) |
| **Most Surplus Governorates** | Governorates with the highest aggregate Surplus Index. | Sum of Surplus Index across all drugs per governorate. | N/A (Used for ranking) |
| **Market Growth Rate** | The percentage increase in active platform participation over time. | `(Current Active Entities / Previous Month Active Entities) * 100` | Target: > 5% MoM |

### 4. Signal Effectiveness Metrics

| Metric Name | Description | Calculation | Target / Threshold |
|-------------|-------------|-------------|--------------------|
| **Signal Resolution Rate** | The percentage of generated signals that are acknowledged or resolved by users. | `(Resolved Signals / Total Signals) * 100` | Target: > 50% |
| **False Positive Rate** | The percentage of signals dismissed by users as inaccurate. | `(Dismissed Signals / Total Signals) * 100` | Target: < 10% |
