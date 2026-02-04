# Layoffs Analysis Using SQL

## Overview

This project analyzes a global layoffs dataset using SQL, with a focus on building a clean, reliable dataset and extracting insights about how layoffs vary across companies, industries, and time.  

The work is intentionally SQL-only to demonstrate strong fundamentals in data cleaning, window functions, aggregations, and analytical thinking without relying on external tools.

---

## Dataset

The raw data is stored in a table called `layoffs` and includes:
- Company name and location
- Industry
- Number of employees laid off
- Percentage of workforce laid off
- Layoff date
- Company stage
- Country
- Total funding raised (in millions)

A cleaned version of the data is created as `layoffs_staging`, which is used for all analysis.

---

## Data Cleaning Approach

I treated this as a real-world dataset with common quality issues.

Key steps:
- Created a **staging table** to preserve the raw data
- Removed **duplicate records** using `ROW_NUMBER()` and window functions
- Standardized inconsistent values:
  - Normalized industry labels (e.g., consolidating Crypto variants)
  - Trimmed formatting issues in country names
- Handled missing data:
  - Converted blank industries to `NULL`
  - Filled missing industries using a self-join on company name
- Converted dates from strings into proper `DATE` values
- Removed rows where both layoff count and percentage were missing

The result is a clean, analysis-ready table that can be safely reused for downstream analysis.

---

## Exploratory Analysis & Key Results

### Companies with the Largest Layoffs

A small number of large companies account for a disproportionate share of total layoffs:

- Amazon: **18,150**
- Google: **12,000**
- Meta: **11,000**
- Salesforce: **10,090**
- Microsoft & Philips: **10,000 each**
- Ericsson: **8,500**

This shows that while layoffs affect companies of all sizes, **overall job losses are driven primarily by large enterprises**, not startups.

---

### Industries Most Impacted

Industries with the highest total layoffs include:
- Consumer (**47,082**)
- Retail (**43,613**)
- Transportation (**34,498**)
- Finance (**28,344**)
- Healthcare (**25,953**)

Layoffs are concentrated in consumer-facing and operationally intensive industries, suggesting broader demand and cost-structure pressures rather than isolated company failures.

---

### Layoffs Over Time

Monthly aggregation reveals clear layoff waves rather than a steady trend:

- **Early 2020 spike** driven by pandemic uncertainty  
  - April 2020 alone recorded **26,710 layoffs**
- **Relative stability in 2021**, with consistently low monthly layoffs
- **Major resurgence in 2022–2023**
  - November 2022: **53,751 layoffs**
  - January 2023: **84,714 layoffs** (largest single month)

By March 2023, cumulative layoffs exceeded **385,000**, highlighting how quickly job losses accelerate during downturns.

---

### Top Layoff Contributors by Year

Using CTEs and `DENSE_RANK()`, I identified the top 5 companies by layoffs each year:

- **2020**: Uber, Booking.com, Groupon
- **2021**: ByteDance, Katerra, Zillow
- **2022**: Meta, Amazon, Cisco
- **2023**: Google, Microsoft, Amazon

Each year’s layoff totals are driven by a small number of high-impact events, rather than widespread moderate cuts.

---

## Key Takeaways

- Layoffs are **highly concentrated by company and time period**
- Startups are more likely to fully shut down, but **large firms drive total layoff volume**
- Consumer and retail industries were hit hardest overall
- Layoff activity aligns strongly with macroeconomic stress, not gradual decline
- Window functions and CTEs are critical for uncovering year-over-year patterns

---

## Tools & Skills Demonstrated

- SQL (MySQL-style syntax)
- Data cleaning and validation
- Window functions (`ROW_NUMBER`, `DENSE_RANK`, rolling sums)
- CTEs for readable, modular analysis
- Analytical thinking and result interpretation

---

## How to Run

1. Load the raw dataset into a SQL database as `layoffs`
2. Run the cleaning script to generate `layoffs_staging`
3. Run the EDA queries against `layoffs_staging`

---

## Why This Project

This project mirrors the kind of exploratory work done early in real analytics projects: messy data, unclear definitions, and a need to quickly understand where the signal is. The emphasis is on correctness, clarity, and extracting insights that can be explained simply to non-technical stakeholders.
