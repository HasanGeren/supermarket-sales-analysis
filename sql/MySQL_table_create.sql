-- Create the Sales table
CREATE TABLE sales (
    invoice_id VARCHAR(20),
    branch CHAR(1),
    city VARCHAR(50),
    customer_type VARCHAR(10),
    gender VARCHAR(10),
    product_line VARCHAR(50),
    unit_price DECIMAL(10, 2),
    quantity INT,
    tax DECIMAL(10, 2),
    total DECIMAL(10, 2),
    date DATE,
    time TIME,
    payment VARCHAR(20),
    cogs DECIMAL(10, 2),
    gross_margin_percentage DECIMAL(5, 2),
    gross_income DECIMAL(10, 2),
    rating DECIMAL(4, 2)
);

-- OPTIONAL --

-- Load data from the CSV file into the Sales table
-- Enable loading data from a local file
SET GLOBAL local_infile = 1;

-- Adjust the date format in the CSV file to match the table schema
LOAD DATA LOCAL INFILE 'path/to/supermarket_sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(invoice_id, branch, city, customer_type, gender, product_line, unit_price, quantity, tax, total, @date, time, payment, cogs, gross_margin_percentage, gross_income, rating)
SET date = STR_TO_DATE(@date, '%m/%d/%Y');

-- Check the first 10 rows of the loaded data
SELECT * FROM sales LIMIT 10;