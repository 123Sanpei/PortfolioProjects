
# Data Cleaning Project on NashvilleHousing.csv

## Project Goal

The goal of this project is to clean and preprocess the NashvilleHousing.csv dataset to prepare it for further analysis. The dataset contains over 57,000 records of real estate transactions in Nashville, TN between 2013 and 2018. However, the data is messy and contains missing values, duplicates, and inconsistencies that need to be addressed before any meaningful analysis can be performed.

## Implementation Details

To clean the dataset, we used SQL queries to:

-Remove duplicates and invalid data using `DISTINCT`, `WHERE`, and `LIKE`   clauses

-Handle missing values by replacing them with the mean, median, or mode using `CASE` statements and aggregate functions such as `AVG()`, `COUNT()`, and `MAX()`

-Normalize and standardize the data using `JOIN` statements and subqueries

-Convert data types using `CAST()` and `CONVERT` functions


We also used `SELECT` statements to extract relevant columns and create new derived columns that provide more meaningful insights into the data.

## Conclusion

This project demonstrates the importance of data cleaning and preprocessing in data analysis. By cleaning and preparing the data, we can ensure that our analysis is accurate, reliable, and meaningful. The SQL queries used in this project can be easily adapted to other datasets and can serve as a starting point for more complex data cleaning tasks.


