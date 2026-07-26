# Dashboard & Analytics Specification
## Yemen Pharmaceutical Market Intelligence Platform

This document outlines the requirements and layout for the platform's Dashboards. The dashboard is the primary interface through which the Intelligence Engine delivers its insights to stakeholders, including the Drug Authority (هيئة الدواء), regional managers, and pharmaceutical entities. The dashboard is updated to reflect the simplified MVP scope, focusing on market visibility and connection rather than transaction processing.

### 1. Audience-Specific Dashboards

#### 1.1. Macro-Level Dashboard (For Drug Authority / Ministry of Health)
This dashboard provides a national overview of pharmaceutical availability and market health.
- **National Shortage Map**: A heat map of Yemen showing regions with critical drug shortages (based on Shortage Signals).
- **Critical Alerts Feed**: A real-time stream of high-severity Market Signals (e.g., "Critical Shortage of Insulin in Aden - Confidence: 95%").
- **Market Trends**: Line charts showing the Growth/Decline of demand for top 10 therapeutic categories over the last 30 days.
- **Price Volatility Index**: (If price data is enabled) A chart showing the standard deviation of reported prices for essential medicines.

#### 1.2. Regional / Entity Dashboard (For Distributors / Pharmacies)
This dashboard provides localized intelligence to help entities make stocking decisions.
- **Regional Supply/Demand Ratio**: A gauge chart showing the balance of supply vs. demand in the entity's specific Governorate.
- **Local Shortages & Surpluses**: A list of drugs (official or free-text) currently experiencing shortages or surpluses in the entity's city.
- **Invisible Inventory Alerts**: Notifications about potential hidden stock in the region that could be negotiated.
- **My Activity Metrics**: The entity's own performance (Requests fulfilled, Offers closed, Average response time, Connections made).

### 2. Key Visualizations and Components

| Component | Description | Data Source |
|-----------|-------------|-------------|
| **Heat Map (جغرافيا)** | Geographic visualization of Yemen, color-coded by Shortage/Surplus Index per Governorate. | Shortage & Surplus Signals |
| **Trend Lines (اتجاهات)** | Time-series graphs showing the Market Timeline (History, Growth, Decline) for specific drugs. | Market Timeline Data |
| **Top Ranked Lists (ترتيب)** | Ranked lists of "Most Demanded Drugs" and "Highest Surplus Drugs". | Market Metrics |
| **Confidence Gauge (دقة البيانات)** | A visual indicator showing the overall data quality and confidence score of the current market snapshot. | Signal Confidence Scores |

### 3. Interactivity and Filtering
The dashboard must support deep filtering to allow analysts to drill down into the data:
- **Timeframe**: Last 24 hours, Last 7 days, Last 30 days, Custom range.
- **Geography**: National -> Region -> Governorate -> City.
- **Drug Category**: Antibiotics, Cardiovascular, Analgesics, etc.
- **Entity Type**: Hospitals, Pharmacies, Distributors.
- **Entry Type**: Official List vs. Free Text.

### 4. Reporting and Export
- Users must be able to export the current dashboard view as a PDF or CSV.
- Automated weekly reports summarizing the top 5 national shortages and surpluses should be generated and emailed to registered Drug Authority personnel.
