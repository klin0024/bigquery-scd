CREATE TABLE IF NOT EXISTS `cloud-tech-se-sandbox.allen_dataset.employees_type4`
(emp_no INTEGER, birth_date DATE, first_name STRING, last_name STRING, gender STRING, hire_date DATE, is_update INTEGER DEFAULT 1);


CREATE TABLE IF NOT EXISTS `cloud-tech-se-sandbox.allen_dataset.employees_type4_history`
(emp_no INTEGER, birth_date DATE, first_name STRING, last_name STRING, gender STRING, hire_date DATE, update_date DATE DEFAULT CURRENT_DATE());


MERGE INTO `cloud-tech-se-sandbox.allen_dataset.employees_type4` AS t
USING `cloud-tech-se-sandbox.allen_dataset.employees` AS s
ON t.emp_no = s.emp_no
WHEN MATCHED AND t.birth_date <> s.birth_date OR t.first_name <> s.first_name OR t.last_name <> s.last_name OR t.gender <> s.gender OR t.hire_date <> s.hire_date THEN
    UPDATE SET birth_date=s.birth_date, first_name=s.first_name, last_name=s.last_name, gender=s.gender, hire_date=s.hire_date, is_update=1
WHEN MATCHED AND t.birth_date = s.birth_date AND t.first_name = s.first_name AND t.last_name = s.last_name AND t.gender = s.gender AND t.hire_date = s.hire_date AND t.is_update = 1 THEN
    UPDATE SET is_update=0
WHEN NOT MATCHED THEN
    INSERT (emp_no, birth_date, first_name, last_name, gender, hire_date)
    VALUES (s.emp_no, s.birth_date, s.first_name, s.last_name, s.gender, s.hire_date)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;    


INSERT INTO `cloud-tech-se-sandbox.allen_dataset.employees_type4_history`
(emp_no, birth_date, first_name, last_name, gender, hire_date)
SELECT emp_no, birth_date, first_name, last_name, gender, hire_date 
FROM `cloud-tech-se-sandbox.allen_dataset.employees_type4` 
WHERE is_update=1;