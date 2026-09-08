create database hr_data;
-- drop database hr; 
use hr_data;
create table Hr (
    Age int,
    Attrition text,
    BusinessTravel	text, 
    DailyRate int,
	Department	text,
    DistanceFromHome int,	
    Education	int,
    EducationField	text,
    EmployeeNumber	int,
    EnvironmentSatisfaction int,	
    Gender	text,
    HourlyRate	int,
    JobInvolvement	int,
    JobLevel	int,
    JobRole	text,
    JobSatisfaction int,	
    MaritalStatus	text,
    EmployeeID	    int,
    MonthlyIncome	int,
    MonthlyRate	    int,
    NumCompaniesWorked	int,
    OverTime	text,
    PercentSalaryHike	int,
    PerformanceRating	int,
    RelationshipSatisfaction	int,
    StockOptionLevel	int,
    TotalWorkingYears	int,
    TrainingTimesLastYear	int,
    WorkLifeBalance	int,
    YearsAtCompany	int,
    YearsInCurrentRole	int,
    YearsSinceLastPromotion	int,
    YearsWithCurrManager	int,
    AttritionFlag	int,
    IncomeRange int
    );
set GlOBAl LOCAL_infile=on;
LOAD DATA local INFILE 'C:/Program Files/MySQL/MySQL Server 8.0/uploads/hr.csv'
INTO TABLE Hr
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select count(*) from hr;

DESCRIBE hr;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Average Attrition Rate for All Departments

SELECT Department, 
       AVG(AttritionFlag) * 100 AS Attrition_Rate_Percentage
FROM hr
GROUP BY Department;

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Average Hourly Rate of Male Research Scientists

SELECT AVG(HourlyRate) AS Avg_Hourly_Rate
FROM hr
WHERE Gender = 'Male' AND JobRole = 'Research Scientist';

---------------------------------------------------------------
-- 2B. Average Hourly Rate of Female Research Scientists

SELECT AVG(HourlyRate) AS Avg_Hourly_Rate
FROM hr
WHERE Gender = 'Female' AND JobRole = 'Research Scientist';
------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Attrition Rate Vs Monthly Income Stats


SELECT Attrition, 
       AVG(MonthlyIncome) AS Avg_Monthly_Income,
       MIN(MonthlyIncome) AS Min_Income,
       MAX(MonthlyIncome) AS Max_Income
FROM hr
GROUP BY Attrition;
------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Average Working Years for Each Department

SELECT Department, 
       AVG(TotalWorkingYears) AS Avg_Working_Years
FROM hr
GROUP BY Department;
---------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Job Role Vs Work Life Balance

SELECT JobRole, 
       AVG(WorkLifeBalance) AS Avg_WorkLife_Balance
FROM hr
GROUP BY JobRole
ORDER BY Avg_WorkLife_Balance DESC;
----------------------------------------------------------------------------------------------------------------------------------------------
-- 6. Attrition Rate Vs Years Since Last Promotion

SELECT YearsSinceLastPromotion, 
       AVG(AttritionFlag) * 100 AS Attrition_Rate_Percentage
FROM hr
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;
--------------------------------------------------------------------------------------------------------------------------------------------

-- 2 The hourly bases rate of Female Vs Male---------------------------------------------------------------------------------------------------------------------------------------------------

SELECT 
    AVG(CASE WHEN Gender = 'Male' THEN HourlyRate END) AS Male_Avg_HourlyRate,
    AVG(CASE WHEN Gender = 'Female' THEN HourlyRate END) AS Female_Avg_HourlyRate,
    AVG(CASE WHEN Gender = 'Male' THEN HourlyRate END) - 
    AVG(CASE WHEN Gender = 'Female' THEN HourlyRate END) AS Difference
FROM hr
WHERE JobRole = 'Research Scientist'; 