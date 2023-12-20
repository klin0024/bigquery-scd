CREATE TABLE IF NOT EXISTS `cloud-tech-se-sandbox.allen_dataset.employees_type2`
(emp_no INTEGER, birth_date DATE, first_name STRING, last_name STRING, gender STRING, hire_date DATE, is_enable INTEGER DEFAULT 1);


MERGE INTO `cloud-tech-se-sandbox.allen_dataset.employees_type2` AS t
USING `cloud-tech-se-sandbox.allen_dataset.employees` AS s
ON t.emp_no = s.emp_no
WHEN MATCHED AND t.is_enable = 1 AND (t.birth_date <> s.birth_date OR t.first_name <> s.first_name OR t.last_name <> s.last_name OR t.gender <> s.gender OR t.hire_date <> s.hire_date) THEN
    UPDATE SET is_enable=0
WHEN NOT MATCHED BY SOURCE THEN
    UPDATE SET is_enable=0;


INSERT INTO `cloud-tech-se-sandbox.allen_dataset.employees_type2` 
(emp_no, birth_date, first_name, last_name, gender, hire_date)
SELECT s.emp_no, s.birth_date, s.first_name, s.last_name, s.gender, s.hire_date FROM `cloud-tech-se-sandbox.allen_dataset.employees` AS s
LEFT JOIN (SELECT * FROM `cloud-tech-se-sandbox.allen_dataset.employees_type2` WHERE is_enable = 1) AS t
ON s.emp_no = t.emp_no
WHERE t.emp_no IS NULL;