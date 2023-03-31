# Amazon Web Scraping using Python

The objective of this project is to scrape the product details of the Lenovo IdeaPad Gaming 3 Notebook from Amazon using Python and BeautifulSoup.

## Implementation Details

The script will scrape the following details:

-Product title

-Price

-Rating

-Number of rating

The project make use of the `requests`  and `BeautifulSoup` libraries in Python to send an HTTP request to the Amazon product page,
parse the HTML content of the page, and extract the required product details. Then, it outputs a CSV file that can be read using `pandas` library, which 
contains the scraped data plus a Timestamp in order to track when the data was collected.

## Conclusion

This project can also be automated using `time.sleep(86400)` to update the CSV every 24h in order to see the daily changes of the product, which can potentially  be used to create a timeseries of the product.
