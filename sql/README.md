# SQL Data Cleaning and Validation

This directory contains the SQL implementation used to prepare the Online Retail II transaction data for customer analytics.

The workflow uses DuckDB SQL to combine the two annual source tables, standardize data types, inspect data quality, identify duplicate records, and construct a cleaned transaction table for downstream analysis.

## Workflow Overview

### 1. Source Validation

Checks the row counts of the two imported source tables before combining the records.

### 2. Data Consolidation

Combines the 2009–2010 and 2010–2011 transaction tables using `UNION ALL` and retains a source-sheet identifier.

### 3. Data Type Standardization

Uses DuckDB's `TRY_CAST` and `TRY_STRPTIME` functions to convert quantity, price, customer identifiers, and invoice dates into appropriate analytical data types.

### 4. Data Quality Assessment

Checks for invalid or missing invoice dates, missing prices, missing customer identifiers, non-positive quantities, missing descriptions, and exact duplicate records.

### 5. Deduplication

Uses `ROW_NUMBER()` with a partition over the transaction attributes to identify duplicate records and construct the final cleaned table.

## Main Tables

| Table            | Purpose                                                 |
| ---------------- | ------------------------------------------------------- |
| `year_2009_2010` | First annual source table                               |
| `year_2010_2011` | Second annual source table                              |
| `RetailCombined` | Combined transaction data after initial type conversion |
| `RetailCleaned`  | Deduplicated transaction table for downstream analysis  |

## Execution Notes

* Database engine: DuckDB
* SQL development environment: DBeaver
* Input requirement: Both annual source tables must already exist in the DuckDB database.
* The SQL script creates the intermediate and cleaned tables and includes validation queries.
* Run the script in a suitable DuckDB session after confirming that the source tables have been imported.

## Reproducibility

The SQL script documents the data preparation workflow so that the transformations and validation checks can be inspected and repeated.

See [`IKEA_Gifting_BRD.docx`](../docs/IKEA_Gifting_BRD.docx) for the business requirements that define the analytical objectives and scope.
