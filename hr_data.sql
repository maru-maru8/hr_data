USE hr_data;
SET sql_mode = 'TRADITIONAL';
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT * FROM hr_data;

SEEING WHICH DEPARTMENTS HAVE THE MOST EMPLOYEES WITH HIGH A HIGH SALARY;
SELECT 
department,
COUNT(department) AS total_employees,
SUM(CASE WHEN salary = 'high' THEN 1 ELSE 0 END) AS high_salary, 
SUM(CASE WHEN salary = 'low' THEN 1 ELSE 0 END) AS low_salary,
ROUND((SUM(CASE WHEN salary = 'high' THEN 1 ELSE 0 END) * 100) / COUNT(department),1) AS percent_with_high_salary
FROM hr_data
GROUP BY department
ORDER BY percent_with_high_salary DESC;

SEEING WHICH DEPARTMENT HAS THE HAPPIEST EMPLOYEES AND WHAT THEIR SALARY LOOKS LIKE;
SELECT DISTINCT(department), satisfaction_level, salary
FROM hr_data
GROUP BY department
ORDER BY satisfaction_level DESC; 

SEEING WHICH DEPARTMENT HAS THE HIGHEST MONTHLY HOURS AND IF IT EFFECTS THE TIME SPENT WITH THE COMPANY;
SELECT DISTINCT(department), average_montly_hours AS above_avg_hours, time_spend_company
FROM hr_data
WHERE average_montly_hours > (SELECT AVG(average_montly_hours) FROM hr_data )
GROUP BY department
ORDER BY above_avg_hours DESC;

SEEING IF EMPLOYEES WHO WORKED LESS HOURS THAN THE AVERAGE STAYED WITH THE COMPANY LONGER;
SELECT (department), average_montly_hours AS below_avg_hours, time_spend_company
FROM hr_data
WHERE average_montly_hours < (SELECT AVG(average_montly_hours) FROM hr_data )
GROUP BY department
ORDER BY below_avg_hours DESC;

CHECKING WHICH DEPARTMENTS HAD THE MOST PROJECTS AND PUT IN THE MOST HOURS AS WELL AS HOW LONG THEY WERE WITH THE COMPANY ON AVERAGE;
SELECT department, SUM(number_project) AS total_projects, SUM(average_montly_hours) AS total_hours, ROUND(AVG(time_spend_company),2) AS avg_tenure
FROM hr_data
GROUP BY department
ORDER BY avg_tenure DESC;










