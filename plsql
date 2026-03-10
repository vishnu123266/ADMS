mysql> create database prod;
Query OK, 1 row affected (0.02 sec)

mysql> use prod;
Database changed
mysql> show tables;
Empty set (0.01 sec)

mysql> SHOW TABLES;
Empty set (0.01 sec)

mysql> CREATE TABLE employees (
    ->     emp_id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     salary DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO employees VALUES
    -> (1,'Aman',25000),
    -> (2,'Rahul',35000),
    -> (3,'Sara',20000);
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> DELIMITER $$
mysql> 
mysql> CREATE PROCEDURE increase_salary_cursor()
    -> BEGIN
    ->     DECLARE done INT DEFAULT 0;
    ->     DECLARE v_emp_id INT;
    ->     DECLARE v_salary DECIMAL(10,2);
    -> 
    ->     DECLARE emp_cursor CURSOR FOR
    ->         SELECT emp_id, salary FROM employee WHERE salary < 30000;
    -> 
    ->     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -> 
    ->     OPEN emp_cursor;
    -> 
    ->     read_loop: LOOP
    ->         FETCH emp_cursor INTO v_emp_id, v_salary;
    -> 
    ->         IF done = 1 THEN
    ->             LEAVE read_loop;
    ->         END IF;
    -> 
    ->         UPDATE employee
    ->         SET salary = v_salary * 1.10
    ->         WHERE emp_id = v_emp_id;
    -> 
    ->     END LOOP;
    -> 
    ->     CLOSE emp_cursor;
    -> END $$
Query OK, 0 rows affected (0.03 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL increase_salary_cursor();
ERROR 1146 (42S02): Table 'prod.employee' doesn't exist
mysql> create table employee(
    -> emp_id int primary key,
    -> name varchar(50),
    -> salary decimal(10,2));
Query OK, 0 rows affected (0.05 sec)

mysql> insert into employee values
    -> (1,'Aman',25000),
    -> (2,'Rahul',35000),
    -> (3,'Sara',20000);
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> DELIMITER $$
mysql> 
mysql> CREATE PROCEDURE increase_salary_cursor()
    -> BEGIN
    ->     DECLARE done INT DEFAULT 0;
    ->     DECLARE v_emp_id INT;
    ->     DECLARE v_salary DECIMAL(10,2);
    -> 
    ->     DECLARE emp_cursor CURSOR FOR
    ->         SELECT emp_id, salary FROM employee WHERE salary < 30000;
    -> 
    ->     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -> 
    ->     OPEN emp_cursor;
    -> 
    ->     read_loop: LOOP
    ->         FETCH emp_cursor INTO v_emp_id, v_salary;
    -> 
    ->         IF done = 1 THEN
    ->             LEAVE read_loop;
    ->         END IF;
    -> 
    ->         UPDATE employee
    ->         SET salary = v_salary * 1.10
    ->         WHERE emp_id = v_emp_id;
    -> 
    ->     END LOOP;
    -> 
    ->     CLOSE emp_cursor;
    -> 
    -> END $$
ERROR 1304 (42000): PROCEDURE increase_salary_cursor already exists
mysql> 
mysql> DELIMITER ;
mysql> CALL increase_salary_cursor();
Query OK, 0 rows affected (0.03 sec)

mysql> select*from employee;
+--------+-------+----------+
| emp_id | name  | salary   |
+--------+-------+----------+
|      1 | Aman  | 27500.00 |
|      2 | Rahul | 35000.00 |
|      3 | Sara  | 22000.00 |
+--------+-------+----------+
3 rows in set (0.00 sec)

mysql> CREATE TABLE electricity (
    ->     cust_id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     units INT,
    ->     bill DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO electricity VALUES
    -> (1,'Arun',80,NULL),
    -> (2,'Meera',150,NULL),
    -> (3,'Rahul',250,NULL);
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> DELIMITER $$
mysql> 
mysql> CREATE PROCEDURE calculate_bill()
    -> BEGIN
    ->     DECLARE done INT DEFAULT 0;
    ->     DECLARE v_id INT;
    ->     DECLARE v_units INT;
    ->     DECLARE v_bill DECIMAL(10,2);
    -> 
    ->     DECLARE cur CURSOR FOR
    ->         SELECT cust_id, units FROM electricity;
    -> 
    ->     DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -> 
    ->     OPEN cur;
    -> 
    ->     read_loop: LOOP
    ->         FETCH cur INTO v_id, v_units;
    -> 
    ->         IF done = 1 THEN
    ->             LEAVE read_loop;
    ->         END IF;
    -> 
    ->         IF v_units <= 100 THEN
    ->             SET v_bill = v_units * 1.5;
    ->         ELSEIF v_units <= 200 THEN
    ->             SET v_bill = (100*1.5) + (v_units-100)*2.5;
    ->         ELSE
    ->             SET v_bill = (100*1.5) + (100*2.5) + (v_units-200)*4;
    ->         END IF;
    -> 
    ->         UPDATE electricity
    ->         SET bill = v_bill
    ->         WHERE cust_id = v_id;
    -> 
    ->     END LOOP;
    -> 
    ->     CLOSE cur;
    -> 
    -> END $$
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DELIMITER ;
mysql> CALL calculate_bill();
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT * FROM electricity;
+---------+-------+-------+--------+
| cust_id | name  | units | bill   |
+---------+-------+-------+--------+
|       1 | Arun  |    80 | 120.00 |
|       2 | Meera |   150 | 275.00 |
|       3 | Rahul |   250 | 600.00 |
+---------+-------+-------+--------+
3 rows in set (0.00 sec)

mysql> CREATE TABLE emp_history (
    ->     emp_id INT,
    ->     name VARCHAR(50),
    ->     salary DECIMAL(10,2),
    ->     dept VARCHAR(50),
    ->     date_of_deletion DATETIME
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql> INSERT INTO employee (emp_id, name, salary, dept) VALUES
    -> (1, 'Arun', 25000, 'IT'),
    -> insert into emp_history (emp_id,name,salary,dept)VALUES
    -> (2, 'Meera', 35000, 'Sales'),
    -> (3, 'Rahul', 20000, 'HR'),
    -> (4, 'Sara', 40000, 'Finance');
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'insert into emp_history (emp_id,name,salary,dept)VALUES
(2, 'Meera', 35000, 'Sal' at line 3
mysql> INSERT INTO emp_history (emp_id, name, salary, dept, date_of_deletion) VALUES
    -> (1, 'Arun', 25000, 'IT', NOW()),
    -> (2, 'Meera', 35000, 'Sales', NOW()),
    -> (3, 'Rahul', 20000, 'HR', NOW()),
    -> (4, 'Sara', 40000, 'Finance', NOW());
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> DELIMITER $$
mysql> 
mysql> CREATE TRIGGER after_employee_delete
    -> AFTER DELETE ON employee
    -> FOR EACH ROW
    -> BEGIN
    ->     INSERT INTO emp_history (emp_id, name, salary, dept, date_of_deletion)
    ->     VALUES (OLD.emp_id, OLD.name, OLD.salary, OLD.dept, NOW());
    -> END $$
ERROR 1054 (42S22): Unknown column 'dept' in 'OLD'
mysql> 
mysql> DELIMITER ;
mysql> -- Delete a row
mysql> DELETE FROM employee WHERE emp_id = 2;
Query OK, 1 row affected (0.01 sec)

mysql> 
mysql> -- Check history table
mysql> SELECT * FROM emp_history;
+--------+-------+----------+---------+---------------------+
| emp_id | name  | salary   | dept    | date_of_deletion    |
+--------+-------+----------+---------+---------------------+
|      1 | Arun  | 25000.00 | IT      | 2026-03-10 14:28:21 |
|      2 | Meera | 35000.00 | Sales   | 2026-03-10 14:28:21 |
|      3 | Rahul | 20000.00 | HR      | 2026-03-10 14:28:21 |
|      4 | Sara  | 40000.00 | Finance | 2026-03-10 14:28:21 |
+--------+-------+----------+---------+---------------------+
4 rows in set (0.00 sec)

mysql> CREATE TABLE emp_details (
    ->     emp_id INT PRIMARY KEY,
    ->     name VARCHAR(50),
    ->     job_id VARCHAR(10),
    ->     salary DECIMAL(10,2)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO emp_details (emp_id, name, job_id, salary) VALUES
    -> (1, '  Arun  ', 'it001', 25000),
    -> (2, '  Meera  ', 'hr002', 30000),
    -> (3, ' Rahul  ', 'sa003', 20000),
    -> (4, '  Sara', 'fi004', 40000);
Query OK, 4 rows affected (0.01 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql> DELIMITER $$
mysql> 
mysql> CREATE TRIGGER before_emp_insert
    -> BEFORE INSERT ON emp_details
    -> FOR EACH ROW
    -> BEGIN
    ->     -- Remove leading/trailing spaces from NAME
    ->     SET NEW.name = TRIM(NEW.name);
    -> 
    ->     -- Convert JOB_ID to uppercase
    ->     SET NEW.job_id = UPPER(NEW.job_id);
    -> END $$
Query OK, 0 rows affected (0.01 sec)

mysql> 
mysql> DELIMITER ;
mysql> -- Insert with spaces in name and lowercase job_id
mysql> INSERT INTO emp_details (emp_id, name, job_id, salary)
    -> VALUES (1, '  Arun  ', 'it001', 25000);
ERROR 1062 (23000): Duplicate entry '1' for key 'emp_details.PRIMARY'
mysql> 
mysql> -- Check the table
mysql> SELECT * FROM emp_details;
+--------+-----------+--------+----------+
| emp_id | name      | job_id | salary   |
+--------+-----------+--------+----------+
|      1 |   Arun    | it001  | 25000.00 |
|      2 |   Meera   | hr002  | 30000.00 |
|      3 |  Rahul    | sa003  | 20000.00 |
|      4 |   Sara    | fi004  | 40000.00 |
+--------+-----------+--------+----------+
4 rows in set (0.00 sec)

mysql> create database m;
Query OK, 1 row affected (0.02 sec)

mysql> user m;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'user m' at line 1
mysql> use m;
Database changed
mysql> CREATE TABLE students (
    ->     student_id INT PRIMARY KEY AUTO_INCREMENT,
    ->     name VARCHAR(50) NOT NULL,
    ->     subject1 INT DEFAULT 0,
    ->     subject2 INT DEFAULT 0,
    ->     subject3 INT DEFAULT 0,
    ->     total_marks INT DEFAULT 0,
    ->     percentage DECIMAL(5,2) DEFAULT 0.00,
    ->     grade VARCHAR(2) DEFAULT 'F'
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> -- Insert a student
mysql> INSERT INTO students (name, subject1, subject2, subject3)
    -> VALUES ('Alice', 85, 90, 78);
Query OK, 1 row affected (0.02 sec)

mysql> DELIMITER $$
mysql> 
mysql> CREATE TRIGGER trg_after_update_marks
    -> BEFORE UPDATE ON students
    -> FOR EACH ROW
    -> BEGIN
    ->     DECLARE total INT;
    ->     DECLARE perc DECIMAL(5,2);
    ->     DECLARE grd VARCHAR(2);
    -> 
    ->     -- Calculate total marks
    ->     SET total = NEW.subject1 + NEW.subject2 + NEW.subject3;
    -> 
    ->     -- Calculate percentage
    ->     SET perc = (total / 300) * 100;  -- assuming each subject is out of 100
    -> 
    ->     -- Determine grade
    ->     IF perc >= 90 THEN
    ->         SET grd = 'A+';
    ->     ELSEIF perc >= 80 THEN
    ->         SET grd = 'A';
    ->     ELSEIF perc >= 70 THEN
    ->         SET grd = 'B';
    ->     ELSEIF perc >= 60 THEN
    ->         SET grd = 'C';
    ->     ELSEIF perc >= 50 THEN
    ->         SET grd = 'D';
    ->     ELSE
    ->         SET grd = 'F';
    ->     END IF;
    -> 
    ->     -- Update the NEW row before it is saved
    ->     SET NEW.total_marks = total;
    ->     SET NEW.percentage = perc;
    ->     SET NEW.grade = grd;
    -> END $$
Query OK, 0 rows affected (0.03 sec)

mysql> 
mysql> DELIMITER ;
mysql> UPDATE students
    -> SET subject1 = 95, subject2 = 88
    -> WHERE student_id = 1;
Query OK, 1 row affected (0.03 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> 
mysql> SELECT * FROM students;
+------------+-------+----------+----------+----------+-------------+------------+-------+
| student_id | name  | subject1 | subject2 | subject3 | total_marks | percentage | grade |
+------------+-------+----------+----------+----------+-------------+------------+-------+
|          1 | Alice |       95 |       88 |       78 |         261 |      87.00 | A     |
+------------+-------+----------+----------+----------+-------------+------------+-------+
1 row in set (0.00 sec)

mysql> 

