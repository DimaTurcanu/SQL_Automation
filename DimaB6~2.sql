
--1 Query to display the employee id, employee name (first name and last name) for all employees who earn more than the average salary

SELECT employee_id, first_name || ' ' || last_name AS employee_name FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

--2 Query to display the employee name (first name and last name), employee id, and salary of all employees who report to Payam

SELECT first_name || ' ' || last_name AS employee_name, employee_id, salary FROM employees
WHERE manager_id = 122;


--3 Query to display the department number, name (first name and last name), job_id, and department name for all employees in the Finance department

SELECT e.department_id, e.first_name || ' ' || e.last_name AS employee_name, e.job_id, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';

--4 Query to display all the information of the employees whose salary is within the range of the smallest salary and 2500

SELECT * FROM employees
WHERE salary >= (SELECT MIN(salary) FROM employees) AND salary <= 2500;

--5 Query to find the first name, last name, department, city, and state province for each employee

SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

--6 Query to find all those employees who work in department ID 80 or 40. Return first name, last name, department number, and department name

SELECT e.first_name, e.last_name, e.department_id, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.department_id IN (80, 40);

--7 Query to display the employee name (first name and last name) and hire date for all employees in the same department as Clara. Exclude Clara

SELECT e.first_name, e.last_name, e.hire_date FROM employees e
JOIN employees c ON e.department_id = c.department_id
WHERE c.first_name = 'Clara' AND e.employee_id <> c.employee_id;

--8 Query to display the employee number, name (first name and last name), and salary for all employees who 
-- earn more than the average salary and who work in a department with any employee with a J in their name

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, e.salary FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (SELECT AVG(salary) FROM employees) AND EXISTS
    (SELECT 1 FROM employees WHERE department_id = d.department_id AND first_name LIKE '%J%');
    
--9 Query to find those employees whose first name contains the letter 'z'. Return first name, last name, department, city, and state province

SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE e.first_name LIKE '%z%';

--10 Query to find all departments, including those without employees. Return first name, last name, department ID, and department name:

SELECT e.first_name, e.last_name, d.department_id, d.department_name FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;

--11 Query to display the employee number, name (first name and last name), and job title for all employees whose salary is smaller than any salary of those employees whose job title is MK_MAN:

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, e.job_title FROM employees e
WHERE e.salary < ANY (SELECT salary FROM employees WHERE job_title = 'MK_MAN');

--12 Query to display the employee number, name (first name and last name), and job title for all employees whose salary is more than any salary of those employees whose job title is PU_MAN. Exclude job title PU_MAN

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, e.job_title FROM employees e
WHERE e.salary > ANY (SELECT salary FROM employees WHERE job_title = 'PU_MAN')
    AND e.job_title <> 'PU_MAN';
    
--13 Query to display the employee number, name (first name and last name), and job title for all employees whose salary is more than any average salary of any department:

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, e.job_title FROM employees e
WHERE e.salary > ANY (SELECT AVG(salary) FROM employees GROUP BY department_id);

--14 Query to display the department ID and the total salary for those departments which contain at least one employee

SELECT department_id, SUM(salary) AS total_salary FROM employees
GROUP BY department_id
HAVING COUNT(*) > 0;

--15 Query to find the employees who earn less than the employee of ID 182. Return first name, last name, and salary

SELECT first_name, last_name, salary FROM employees
WHERE salary < (SELECT salary FROM employees WHERE employee_id = 182);

--16 Query to find the employees and their managers. Return the first name of the employee and manager

SELECT e.first_name AS employee_name, m.first_name AS manager_name FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

--17 Query to display the department name, city, and state province for each department

SELECT d.department_name, l.city, l.state_province FROM departments d
JOIN locations l ON d.location_id = l.location_id;

--18 Query to identify all the employees who earn more than the average and who work in any of the IT departments

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, e.salary FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (SELECT AVG(salary) FROM employees) AND d.department_name LIKE '%IT%';

--19 Query to find out which employees have or do not have a department. Return first name, last name, department ID, and department name

SELECT e.first_name, e.last_name, d.department_id, d.department_name FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

--20 Query to find the employees and their managers. Those managers do not work under any manager also appear in the list. Return the first name of the employee and manager

SELECT e.first_name AS employee_name, m.first_name AS manager_name FROM employees e
LEFT JOIN employees m ON e.manager_id =m.employee_id;

--21 Query to display the name (first name and last name) for those employees who get more salary than the employee whose ID is 163

SELECT first_name || ' ' || last_name AS employee_name FROM employees
WHERE salary > (SELECT salary FROM employees WHERE employee_id = 163);

--22 Query to display the name (first name and last name), salary, department id, and job id for those employees who work in the same designation as the employee whose id is 169

SELECT first_name || ' ' || last_name AS employee_name, salary, department_id, job_id FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 169);

--23 Query to find the employees who work in the same department as the employee with the last name Taylor. Return first name, last name, and department ID

SELECT first_name, last_name, department_id
FROM employees
WHERE department_id = (SELECT department_id FROM employees WHERE last_name = 'Taylor');

--24 Query to find the department name and the full name (first and last name) of the manager

SELECT d.department_name, m.first_name || ' ' || m.last_name AS manager_name FROM departments d
JOIN employees m ON d.manager_id = m.employee_id;

--25 Query to find the employees who earn $12000 or more. Return employee ID, starting date, end date, job ID, and department ID

SELECT employee_id, start_date, end_date, job_id, department_id FROM job_history
WHERE salary >= 12000;

--26 Query to display the name (first name and last name), salary, and department ID for those employees who earn the smallest amount of salary among all departments

SELECT first_name || ' ' || last_name AS employee_name, salary, department_id FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees GROUP BY department_id);

--27 Query to display all the information of an employee whose salary and reporting person ID are 3000 and 121, respectively

SELECT * FROM employees
WHERE salary = 3000 AND manager_id = 121;

--28 Query to display the employee name (first name and last name), employee ID, and job title for all employees whose department location is Toronto

SELECT e.first_name || ' ' || e.last_name AS employee_name, e.employee_id, e.job_title FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'Toronto';

--29 Query to display the employee name (first name and last name) and department for all employees for any existence of those employees whose salary is more than 3700

SELECT e.first_name || ' ' || e.last_name AS employee_name, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE EXISTS (SELECT 1 FROM employees WHERE salary > 3700);

--30 Query to determine who earns more than an employee with the last name 'Russell'

SELECT e.first_name || ' ' || e.last_name AS employee_name FROM employees e
WHERE e.salary > (SELECT salary FROM employees WHERE last_name = 'Russell');

--31 Query to display the names of employees who don't have a manager

SELECT first_name || ' ' || last_name AS employee_name FROM employees
WHERE manager_id IS NULL;

--32 Query to display the names of the departments and the number of employees in each department

SELECT d.department_name, COUNT(*) AS employee_count FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

--33 Query to display the last name of employees and the city where they are located

SELECT last_name, city FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

--34 Query to display the job titles and the average salary of employees for each job title

SELECT job_title, AVG(salary) AS average_salary FROM employees 
GROUP BY job_title;

--35 Query to display the employee's name, department name, and the city of the department

SELECT e.first_name || ' ' || e.last_name AS employee_name, d.department_name, l.city FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id;

--36 Query to display the names of employees who do not have a department assigned to them

SELECT first_name || ' ' || last_name AS employee_name FROM employees
WHERE department_id IS NULL;

--37 Query to display the names of all departments and the number of employees in them, even if there are no employees in the department

SELECT d.department_name, COUNT(e.employee_id) AS employee_count FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

--38 Query to display the names of employees and the department names, but only include employees whose salary is above 10,000

SELECT e.first_name || ' ' || e.last_name AS employee_name, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 10000;

--39 Query to display department names and the average salary within each department, but only for departments with an average salary above 7000

SELECT d.department_name, AVG(e.salary) AS average_salary FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 7000;

--40 Query to display the names of employees who work in the 'IT' department

SELECT first_name || ' ' || last_name AS employee_name FROM employees
JOIN departments ON employees.department_id = departments.department_id
WHERE departments.department_name = 'IT';

--41 Query which looks for the names of all employees whose salary is greater than 50% of their department’s total salary bill

SELECT e.first_name || ' ' || e.last_name AS employee_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > (0.5 * (SELECT SUM(salary) FROM employees WHERE department_id = d.department_id));

--42 Query to get the details of employees who are managers

SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, e.job_title FROM employees e
JOIN employees m ON e.employee_id = m.manager_id;

--43 Query to display the department code and name for all departments located in the city London

SELECT d.department_id, d.department_name FROM departments d
JOIN locations l ON d.location_id = l.location_id
WHERE l.city = 'London';

--44 Query to display the first and last name,salary, and department ID for all employees who earn more than the average salary and arrange the list in descending order on salary

SELECT first_name, last_name, salary, department_id FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

--45 Query to display the first and last name, salary, and department ID for those employees who earn more than the maximum salary of a department with ID 40

SELECT first_name, last_name, salary, department_id FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE department_id = 40);

--46 Query to display the department name and ID for all departments located in the same location as the department number 30

SELECT d.department_name, d.department_id FROM departments d
JOIN locations l ON d.location_id = l.location_id
WHERE l.location_id = (SELECT location_id FROM departments WHERE department_id = 30);

--47 Query to display the details of departments managed by Susan

SELECT d.department_id, d.department_name, e.first_name || ' ' || e.last_name AS manager_name FROM departments d
JOIN employees e ON d.manager_id = e.employee_id
WHERE e.first_name = 'Susan';

--48 Query to display the department names and location cities. Only include departments that are located in a country with the country_id 'US'

SELECT d.department_name, l.city FROM departments d
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
WHERE c.country_id = 'US';

--49 Query to display the first name and last name of employees along with the name of the department they work in. Only include employees whose last name starts with the letter 'S'

SELECT e.first_name, e.last_name, d.department_name FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.last_name LIKE 'S%';

--50 Query to display the department names and the number of employees in each department. Only include departments with more than 2 employees and order the result by the number of employees in descending order

SELECT d.department_name, COUNT(e.employee_id) AS employee_count FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 2
ORDER BY COUNT(e.employee_id) DESC;



