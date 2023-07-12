CREATE DATABASE mcdonald_db

SHOW DATABASES

USE mcdonald_db

# Confirm Data is Loaded Properly or Not

select * from mcdonaldata

# See Data Structure

SHOW TABLES
DESCRIBE mcdonaldata

# Count the number of rows in the dataset

SELECT COUNT(*) as total_rows FROM mcdonaldata ---- 141

# Identify missing value in specific column

SELECT count(*) AS missing_val
FROM mcdonaldata
WHERE item is NULL; ---- No missing value

# Check data distribution for numerical value

SELECT MIN(calories) AS min_val, MAX(calories) AS max_val, AVG(calories) AS avg_val
FROM mcdonaldata
WHERE calories IS NOT NULL

# Update value with rounded value

UPDATE mcdonaldata
SET protien = Round(protien,2)

SELECT * FROM mcdonaldata

# Find distinct menu type
SELECT DISTINCT menu from mcdonaldata

# Total Menu items

SELECT DISTINCT COUNT(*) AS total_item
FROM mcdonaldata

# Top 3 items with highest amount of calories

SELECT item FROM mcdonaldata
ORDER BY calories DESC
LIMIT 3

SELECT item FROM mcdonaldata
ORDER BY sugar DESC
LIMIT 3

# Find it any items in menu contains 0 sugar

SELECT item FROM mcdonaldata
WHERE sugar = 0 AND addedsugar = 0

SELECT item, transfat FROM mcdonaldata
ORDER BY transfat DESC

# The average amount of fat in grams across all menu types

SELECT avg(totalfat) Avg_Fat FROM mcdonaldata

# the menu item with highest number of proteins

SELECT menu, protien from mcdonaldata
ORDER BY protien DESC
LIMIT 1

# Find total items in each category

SELECT menu AS categories, COUNT(*) AS total_items
FROM mcdonaldata
GROUP BY menu

# Find Average all nutrients in all categories

SELECT menu AS Categories,
      Round(avg(servesize),2) AS servesize,
      Round(avg(calories),2) AS calories,
      Round(avg(totalfat),2) AS fat
FROM mcdonaldata
GROUP BY menu

# Category Analysis

SELECT 
   DISTINCT menu,
   
   MAX(servesize) OVER (PARTITION BY menu) AS serve_size,
   MAX(sugar + addedsugar) OVER (PARTITION BY menu) AS Max_sugar,
   MIN(sugar + addedsugar) OVER (PARTITION BY menu) AS Min_sugar,
   AVG(sugar + addedsugar) OVER (PARTITION BY menu) AS Avg_sugar,
   VARIANCE(sugar + addedsugar) OVER (PARTITION BY menu) AS var_sugar,
   STDDEV(sugar + addedsugar) OVER (PARTITION BY menu) AS stdev_sugar
FROM mcdonaldata;
   

# acceptable per day sugar level for men is

SELECT menu, avg(sugar + addedsugar) FROM mcdonaldata
GROUP BY menu
HAVING avg(sugar + addedsugar) > 24

SELECT item, menu, sugar, addedsugar FROM mcdonaldata
WHERE (sugar + addedsugar) > 24

# sugar where you least expect

SELECT item, menu, sugar, addedsugar FROM mcdonaldata
WHERE menu in ('regular', 'breakfast', 'gourmet', 'condiments') and (sugar + addedsugar) > 24

# Trans fat
 
SELECT item, transfat FROM mcdonaldata
WHERE transfat > 2.2
 
# By Item

SELECT item, avg(calories) AS avg_cal,
	avg(totalfat) AS avg_fat,
    avg(sugar) AS avg_sugar,
    avg(addedsugar) AS avg_addsugar,
    avg(protien) AS avg_protein,
    avg(sodium) AS avg_sodium
FROM mcdonaldata
WHERE item LIKE '%Burger%'
GROUP BY item
ORDER BY avg(calories) DESC


