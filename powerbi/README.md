# Power BI — Customer Analytics Dashboard

This directory contains the Power BI report developed for the IKEA Gifting Customer Analytics project.

The report presents customer value, RFM segmentation, retention patterns, and country-level comparisons using interactive visualizations and business performance measures.

## Dashboard Pages

The current Power BI report contains two pages.

### 1. Overview

The Overview page provides a high-level view of customer and revenue performance.

**Key performance indicators**

* Total Revenue
* Total Customers
* Churn Percentage
* Average Customer Value

**Analytical views**

* Total revenue by customer segment
* Total customers by segment
* Revenue retention by segment
* Customer retention by segment
* Customer and revenue trends

The page also includes interactive filtering and report controls to explore customer and revenue performance.

### 2. RFM Analysis

The RFM Analysis page provides a more detailed examination of customer segments and geographic performance.

**Segment analysis**

* Segment performance summary, including customer counts, revenue, and RFM scores
* Average customer value by segment
* Customer and retention trends

**Geographic analysis**

* Country performance summary
* Top five countries by average customer value
* Comparisons of customer and revenue performance across countries

These views support a more detailed assessment of customer value and retention patterns.

## Technology Stack

| Technology        | Role                                        |
| ----------------- | ------------------------------------------- |
| Power BI Desktop  | Interactive dashboard development           |
| DAX measures      | Business metrics and KPI calculations       |
| SQL-prepared data | Transaction data preparation                |
| Python analysis   | Customer-level RFM scoring and segmentation |

## Business Purpose

The report translates transaction and customer-level analysis into business intelligence that can support decisions concerning customer prioritization, retention, and marketing resource allocation.

The analytical scope follows the objectives established in the [Business Requirements Document](../docs/IKEA_Gifting_BRD.docx).

## Reproducibility

The Power BI report is provided as a `.pbix` file.

Reproducing the report requires the relevant prepared data and the source configuration used by the report. Exact refresh instructions will be documented after the project files and data dependencies have been organized.

## Project Disclaimer

IKEA Gifting is a fictional company name used for this educational portfolio project. This project is not affiliated with, endorsed by, or representative of the real IKEA corporation. The analysis is based on a public historical retail transaction dataset.
