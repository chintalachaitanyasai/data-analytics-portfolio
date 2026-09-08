use zomato_project;
show tables;
select * from orders;
/*
1. Build a country Map Table
*/
CREATE TABLE country_map (
    CountryCode INT,
    CountryName VARCHAR(50)
);
INSERT INTO country_map (CountryCode, CountryName)
VALUES
(1,'India'),
(14,'Australia'),
(30,'Brazil'),
(37,'Canada'),
(94,'Indonesia'),
(148,'New Zealand'),
(162,'Philippines'),
(166,'Qatar'),
(184,'Singapore'),
(189,'South Africa'),
(191,'Sri Lanka'),
(208,'Turkey'),
(214,'UAE'),
(215,'United Kingdom'),
(216,'United States');
SELECT * FROM country_map;

/*
2. Build a Calendar Table using the Column Datekey
*/

CREATE TABLE calendar_table (
    DateKey DATE,
    Year INT,
    MonthNo INT,
    MonthFullName VARCHAR(20),
    QuarterName VARCHAR(5),
    YearMonth VARCHAR(10),
    WeekdayNo INT,
    WeekdayName VARCHAR(20),
    FinancialMonth VARCHAR(10),
    FinancialQuarter VARCHAR(10)
);
DESC orders;
INSERT INTO calendar_table
SELECT DISTINCT
    DateKey_opening,

    YEAR( DateKey_opening) AS Year,

    MONTH( DateKey_opening) AS MonthNo,

    MONTHNAME( DateKey_opening) AS MonthFullName,

    CONCAT('Q',QUARTER( DateKey_opening)) AS QuarterName,

    DATE_FORMAT( DateKey_opening,'%Y-%b') AS YearMonth,

    DAYOFWEEK( DateKey_opening) AS WeekdayNo,

    DAYNAME( DateKey_opening) AS WeekdayName,

    CASE
        WHEN MONTH( DateKey_opening)=4 THEN 'FM1'
        WHEN MONTH( DateKey_opening)=5 THEN 'FM2'
        WHEN MONTH( DateKey_opening)=6 THEN 'FM3'
        WHEN MONTH( DateKey_opening)=7 THEN 'FM4'
        WHEN MONTH( DateKey_opening)=8 THEN 'FM5'
        WHEN MONTH( DateKey_opening)=9 THEN 'FM6'
        WHEN MONTH( DateKey_opening)=10 THEN 'FM7'
        WHEN MONTH( DateKey_opening)=11 THEN 'FM8'
        WHEN MONTH( DateKey_opening)=12 THEN 'FM9'
        WHEN MONTH( DateKey_opening)=1 THEN 'FM10'
        WHEN MONTH( DateKey_opening)=2 THEN 'FM11'
        WHEN MONTH( DateKey_opening)=3 THEN 'FM12'
    END AS FinancialMonth,

    CASE
        WHEN MONTH( DateKey_opening) IN (4,5,6) THEN 'FQ1'
        WHEN MONTH( DateKey_opening) IN (7,8,9) THEN 'FQ2'
        WHEN MONTH( DateKey_opening) IN (10,11,12) THEN 'FQ3'
        WHEN MONTH( DateKey_opening) IN (1,2,3) THEN 'FQ4'
    END AS FinancialQuarter

FROM orders;
SELECT * FROM calendar_table;

			/* 
				3. Number of Restaurants based on City and Country
			*/
SELECT * FROM calendar_table;
SELECT
    c.CountryName,
    o.City,
    COUNT(o.ï»¿RestaurantID) AS TotalRestaurants
FROM orders o
JOIN country_map c
ON o.CountryCode = c.CountryCode
GROUP BY c.CountryName, o.City
ORDER BY TotalRestaurants DESC;

/*
4.Numbers of Resturants opening based on Year , Quarter , Month
*/
/*By Year*/

SELECT
    YEAR(DateKey_opening) AS Year,
    COUNT(ï»¿RestaurantID) AS TotalRestaurants
FROM orders
GROUP BY YEAR(DateKey_opening);

/*
By Quarter
*/
SELECT
    CONCAT('Q',QUARTER(DateKey_opening)) AS QuarterName,
    COUNT(ï»¿RestaurantID) AS TotalRestaurants
FROM orders
GROUP BY QUARTER(DateKey_opening);

/*
5  Count of Restaurants based on Average Rating
*/
SELECT
    Rating,
    COUNT(ï»¿RestaurantID) AS TotalRestaurants
FROM orders
GROUP BY Rating
ORDER BY Rating DESC;

/*
6  Buckets based on Average Price
*/
SELECT
    CASE
        WHEN Average_Cost_for_two BETWEEN 0 AND 500 THEN '0-500'
        WHEN Average_Cost_for_two BETWEEN 501 AND 1000 THEN '501-1000'
        WHEN Average_Cost_for_two BETWEEN 1001 AND 2000 THEN '1001-2000'
        ELSE '2000+'
    END AS PriceBucket,

    COUNT(ï»¿RestaurantID) AS TotalRestaurants

FROM orders

GROUP BY PriceBucket
ORDER BY TotalRestaurants DESC;

/*
7  Percentage of Restaurants based on Has_Table_booking
*/
SELECT
    Has_Table_booking,

    COUNT(*) AS TotalRestaurants,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS Percentage

FROM orders

GROUP BY Has_Table_booking;

/*
8 Percentage of Restaurants based on Has_Online_delivery
*/

SELECT
    Has_Online_delivery,

    COUNT(*) AS TotalRestaurants,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM orders),
        2
    ) AS Percentage

FROM orders

GROUP BY Has_Online_delivery;
/*
9  Based on Cuisine, City, Ratings
*/
/*
Cuisine
*/
SELECT
    Cuisines,
    COUNT(ï»¿RestaurantID) AS TotalRestaurants
FROM orders
GROUP BY Cuisines
ORDER BY TotalRestaurants DESC
LIMIT 10;

/*
City
*/
SELECT
    City,
    COUNT(ï»¿RestaurantID) AS TotalRestaurants
FROM orders
GROUP BY City
ORDER BY TotalRestaurants DESC;

/*
Ratings
*/
SELECT
    Rating,
    COUNT(ï»¿RestaurantID) AS TotalRestaurants
FROM orders
GROUP BY Rating
ORDER BY Rating DESC;