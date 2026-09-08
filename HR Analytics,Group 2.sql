CREATE DATABASE HR;

USE HR;

CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY,
    MonthlyIncome INT,
    IncomeGroups VARCHAR(20),
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 CHAR(1),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    SalaryHikePercentage DECIMAL(5,2),
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT,
    Age INT,
    AgeBand VARCHAR(10),
    Attrition VARCHAR(5),
    AttritionFlag INT,
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20)
);

SET GLOBAL local_infile = 1;
LOAD DATA LOCAL INFILE 'E:/Download/ExcelR HR Analytics.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT * FROM employees limit 10;



#KPI 1 

CREATE TABLE KPI1 AS
SELECT 
    Department,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
    ) AS Attrition_Rate_Percentage
FROM employees
GROUP BY Department;

SELECT * FROM KPI1;


#KPI 2

CREATE TABLE KPI2 AS
SELECT 
    ROUND(AVG(HourlyRate), 2) AS Avg_Hourly_Rate
FROM employees
WHERE Gender = 'Male'AND JobRole = 'Research Scientist';

SELECT *FROM KPI2;


#KPI 3 
CREATE TABLE KPI3 AS 
SELECT 
    CASE 
        WHEN MonthlyIncome < 5000 THEN 'Low'
        WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN 'Medium'
        ELSE 'High'
    END AS Income_Category,
    
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Attrition_Rate
FROM employees
GROUP BY Income_Category;
SELECT * FROM KPI3;


#KPI 4 

CREATE TABLE KPI4 AS 
SELECT 
    Department,
    ROUND(AVG(TotalWorkingYears), 2) AS Avg_Working_Years
FROM employees
GROUP BY Department;

SELECT * FROM KPI4;




#KPI 5 

CREATE TABLE KPI5 AS 
SELECT 
    JobRole,
    WorkLifeBalance,
    COUNT(*) AS Employee_Count
FROM employees
GROUP BY JobRole, WorkLifeBalance
ORDER BY JobRole, WorkLifeBalance;

SELECT * FROM KPI5;

#KPI 6
CREATE TABLE KPI6 AS
SELECT 
    CASE 
        WHEN YearsSinceLastPromotion BETWEEN 1 AND 5 THEN '1-5'
        WHEN YearsSinceLastPromotion BETWEEN 6 AND 10 THEN '6-10'
        WHEN YearsSinceLastPromotion BETWEEN 11 AND 15 THEN '11-15'
        WHEN YearsSinceLastPromotion BETWEEN 16 AND 20 THEN '16-20'
        WHEN YearsSinceLastPromotion BETWEEN 21 AND 25 THEN '21-25'
        WHEN YearsSinceLastPromotion BETWEEN 26 AND 30 THEN '26-30'
        WHEN YearsSinceLastPromotion BETWEEN 31 AND 35 THEN '31-35'
        WHEN YearsSinceLastPromotion BETWEEN 36 AND 40 THEN '36-40'
        ELSE 'Other'
    END AS Promotion_Group,

    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2
    ) AS Attrition_Rate

FROM employees
GROUP BY Promotion_Group
ORDER BY Promotion_Group;

SELECT * FROM KPI6;


#ADDITIONAL KPIS

#TOTAL EMPOLYEES 
CREATE TABLE EMP_COUNT AS SELECT COUNT(EmployeeID) AS total_employess 
FROM employees;

SELECT * FROM EMP_COUNT;


#ATTRITION COUNT
CREATE TABLE ATT_COUNT AS SELECT Attrition,COUNT(*) AS employees_count 
FROM employees
GROUP BY Attrition;

SELECT * FROM ATT_COUNT;


#ATTRITION RATE(%)
CREATE TABLE ATT_RATE AS SELECT 
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 
    2) AS attrition_rate_percentage
FROM employees;

SELECT * FROM ATT_RATE;

# AVG MONTHLY INCOME
SELECT 
    ROUND(AVG(MonthlyIncome), 2) AS avg_monthly_income
FROM employees;



#AVG YEARS AT COMPANY

SELECT ROUND(AVG(YearsAtCompany),0) as 
avg_years_at_company FROM employees;




  
  