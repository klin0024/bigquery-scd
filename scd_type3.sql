CREATE TABLE IF NOT EXISTS `cloud-tech-se-sandbox.allen_dataset.employees_type3`
(emp_no INTEGER, birth_date DATE, old_birth_date DATE, first_name STRING, old_first_name STRING, last_name STRING, old_last_name STRING, gender STRING, old_gender STRING, hire_date DATE, old_hire_date DATE);


MERGE INTO `cloud-tech-se-sandbox.allen_dataset.employees_type3` AS t
USING `cloud-tech-se-sandbox.allen_dataset.employees` AS s
ON t.emp_no = s.emp_no
WHEN MATCHED AND t.birth_date <> s.birth_date OR t.first_name <> s.first_name OR t.last_name <> s.last_name OR t.gender <> s.gender OR t.hire_date <> s.hire_date THEN
    UPDATE SET birth_date=s.birth_date, old_birth_date=IF(s.birth_date=t.birth_date, t.old_birth_date, t.birth_date), first_name=s.first_name, old_first_name=IF(s.first_name=t.first_name, t.old_first_name, t.first_name), last_name=s.last_name, old_last_name=IF(s.last_name=t.last_name, t.old_last_name, t.last_name), gender=s.gender, old_gender=IF(s.gender=t.gender, t.old_gender, t.gender), hire_date=s.hire_date, old_hire_date=IF(s.hire_date=t.hire_date, t.old_hire_date, t.hire_date) 
WHEN NOT MATCHED THEN
    INSERT (emp_no, birth_date, first_name, last_name, gender, hire_date)
    VALUES (s.emp_no, s.birth_date, s.first_name, s.last_name, s.gender, s.hire_date)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE; 