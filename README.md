# Supermarket Sales Analysis

## Project Description
This project involves a comprehensive analysis of supermarket sales data sourced from [Kaggle](https://www.kaggle.com). The analysis was conducted using MySQL and Python, leveraging both MySQL and pandas for data manipulation and visualization. The primary objective is to gain insights into various sales performance metrics, customer behaviors, and trends.

## Data Source
The dataset used in this project is sourced from Kaggle: [Supermarket Sales Dataset](https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales).

## Analysis Overview
### Data Insertion
- Loaded data from `supermarket_sales.csv` into a MySQL database.

### Conducted Analyses:
1. **Sales Performance by Branch**: Evaluated the performance of different branches.
2. **Average Rating by Product Line**: Analyzed the average customer ratings for each product line.
3. **Daily Sales**: Examined daily sales trends.
4. **Monthly Sales**: Analyzed sales patterns on a monthly basis.
5. **Weekly Sales**: Looked into weekly sales data.
6. **Customer Preferences by Payment Method**: Investigated customer payment method preferences.
7. **Average Revenue per Customer Type**: Calculated the average revenue generated from different customer types.
8. **Sales Patterns by Day and Time**: Identified patterns in sales based on the day of the week and time of the day.
9. **Customer Segmentation by Spending**: Segmented customers based on their spending habits.
10. **Sales Forecasting**: Forecasted future sales using historical data.
11. **Sales Anomalies**: Detected anomalies in the sales data.

## Installation
### Requirements
- Python 3.x
- MySQL

### Python Libraries
Install the required Python libraries using the `requirements.txt` file:
```bash
pip install -r requirements.txt
```

### Environment Variables
Copy the `.env.example` to `.env` and update it with your MySQL database credentials:
```bash
cp .env.example .env
```

## Usage
### Running the Jupyter Notebooks
- **MySQL Analysis**: Open and run `notebooks/MySQL_supermarket_sales_analysis.ipynb` to see the analysis conducted using MySQL queries.
- **Python Analysis**: Open and run `notebooks/supermarket_sales_analysis.ipynb` to see the analysis and visualizations conducted using pandas and matplotlib.

## Project Files
- **data/supermarket_sales.csv**: The raw dataset used for analysis.
- **notebooks/MySQL_supermarket_sales_analysis.ipynb**: Jupyter notebook containing analysis using MySQL queries.
- **notebooks/supermarket_sales_analysis.ipynb**: Jupyter notebook containing analysis and visualizations using pandas and matplotlib.
- **SQL/MySQL_supermarket_sales_analysis.sql**: SQL scripts used for data analysis.
- **SQL/MySQL_table_create.sql**: SQL script for creating the database tables.
- **SQL/supermarket_sales_db.sql**: Database exported from MySQL Workbench.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements
- The dataset is sourced from [Kaggle](https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales).
- Special thanks to the Kaggle community for providing such a valuable dataset.

