
# Data Cleaning Project on NashvilleHousing.csv

## Project Goal

The goal of this project is to clean and preprocess the NashvilleHousing.csv dataset to prepare it for further analysis. The dataset contains over 57,000 records of real estate transactions in Nashville, TN between 2013 and 2018. However, the data is messy and contains missing values, duplicates, and inconsistencies that need to be addressed before any meaningful analysis can be performed.

## Implementation Details

To clean the dataset, we used SQL queries to:

-Handled empty cells by replacing them with NULL values

-Convert data types using `STR_TO_DATE()`, `REPLACE()` and `ALTER TABLE` + `CHANGE COLUMN`

-Breaking out Address into Individual Columns using `SUBSTRING()`

-Handled invalid entries using `CASE()`

-Remove duplicates using `ROW_NUMBER() OVER()` and `PARTITION BY`

I also used `SELECT` statements to extract relevant columns and create new derived columns that provide more meaningful insights into the data.

## Conclusion

This project demonstrates the importance of data cleaning and preprocessing in data analysis. By cleaning and preparing the data, we can ensure that our analysis is accurate, reliable, and meaningful. The SQL queries used in this project can be easily adapted to other datasets and can serve as a starting point for more complex data cleaning tasks.


