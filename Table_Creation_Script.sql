IF NOT EXISTS (SELECT * FROM sys.databases where name = 'medicalrocket')
    CREATE DATABASE medicalrocket
    GO

USE medicalrocket
GO
--DOWN-->Dropping db objects mentioned in the UP section
ALTER TABLE billing DROP CONSTRAINT IF EXISTS pk_bill_no
GO
ALTER TABLE billing DROP CONSTRAINT IF EXISTS fk_bill_patient_id
GO
DROP TABLE IF EXISTS billing
GO
ALTER TABLE med_prescription DROP CONSTRAINT IF EXISTS fk_med_prec_medSKU
GO
ALTER TABLE med_prescription DROP CONSTRAINT IF EXISTS fk_med_prec_emp_id
GO
ALTER TABLE med_prescription DROP CONSTRAINT IF EXISTS fk_med_patient_id
GO
ALTER TABLE med_prescription DROP CONSTRAINT IF EXISTS pk_med_prescription_id
GO
DROP TABLE med_prescription
GO
ALTER TABLE med_sales DROP CONSTRAINT IF EXISTS pk_med_sales_trac_no
GO
ALTER TABLE med_sales DROP CONSTRAINT IF EXISTS fk_med_sales_patient_id
GO
ALTER TABLE med_sales DROP CONSTRAINT IF EXISTS fk_med_sales_med_SKU
GO
ALTER TABLE med_sales DROP CONSTRAINT IF EXISTS pk_med_sales_trac_no
GO
DROP TABLE IF EXISTS med_sales
GO
ALTER TABLE med_inventory DROP CONSTRAINT IF EXISTS med_inv_medicine_SKU
GO
DROP TABLE IF EXISTS med_inventory
GO
ALTER TABLE medicine_master  DROP CONSTRAINT IF EXISTS uk_medicine_master
GO
ALTER TABLE medicine_master DROP CONSTRAINT IF EXISTS pk_med_master
GO
DROP TABLE IF EXISTS medicine_master
GO
ALTER TABLE lab_report_results DROP CONSTRAINT IF EXISTS fk_lab_report_result_test_code
GO
ALTER TABLE lab_report_results DROP CONSTRAINT IF EXISTS fk_lab_report_result_generated_by
GO
ALTER TABLE lab_report_results DROP CONSTRAINT IF EXISTS fk_lab_report_result_prescribed_by
GO
ALTER TABLE lab_report_results DROP CONSTRAINT IF EXISTS fk_lab_report_result_patient
GO
ALTER TABLE lab_report_results DROP CONSTRAINT IF EXISTS pk_lab_report_results
GO
DROP TABLE IF EXISTS lab_report_results
GO
ALTER TABLE test DROP CONSTRAINT IF EXISTS pk_test_code
GO
DROP TABLE IF EXISTS test
GO
ALTER TABLE room DROP CONSTRAINT IF EXISTS fk_room_patient_id
GO
ALTER TABLE room DROP CONSTRAINT IF EXISTS pk_room_no
GO
DROP TABLE IF EXISTS room
GO
ALTER TABLE employee_paychecks DROP CONSTRAINT IF EXISTS pk_paycheck_id
GO
ALTER TABLE employee_paychecks DROP CONSTRAINT IF EXISTS fk_emp_paycheck_emp_master
GO
DROP TABLE IF EXISTS employee_paychecks
GO
ALTER TABLE employee_speciality DROP CONSTRAINT IF EXISTS fk_emp_spec_emp_id
GO
ALTER TABLE employee_speciality DROP CONSTRAINT IF EXISTS fk_emp_spec_id
GO
DROP TABLE IF EXISTS employee_speciality
GO
ALTER TABLE speciality DROP CONSTRAINT IF EXISTS pk_speciality
GO
DROP TABLE IF EXISTS speciality
GO

ALTER TABLE employee_master DROP CONSTRAINT IF EXISTS fk_employee_dept_id
GO
ALTER TABLE employee_master DROP CONSTRAINT IF EXISTS uk_employee_master_emailaddress
GO
ALTER TABLE employee_master DROP CONSTRAINT IF EXISTS pk_employee_master_eid
GO
DROP TABLE IF EXISTS employee_master
GO
ALTER TABLE departments DROP CONSTRAINT IF EXISTS pk_department_code
GO
DROP TABLE departments
GO
ALTER TABLE patient_insurance DROP CONSTRAINT IF EXISTS fk_patient_insurance_pid
GO
ALTER TABLE patient_insurance DROP CONSTRAINT IF EXISTS uk_patient_in_policy_no
GO
ALTER TABLE patient_insurance DROP CONSTRAINT IF EXISTS pk_patient_in_line_id
GO
DROP TABLE IF EXISTS patient_insurance
GO
ALTER TABLE patient_emergency_contact DROP CONSTRAINT IF EXISTS fk_patient_ec_patient_id
GO
ALTER TABLE patient_emergency_contact DROP CONSTRAINT IF EXISTS pk_patient_emergency_contact_id
GO
DROP TABLE IF EXISTS patient_emergency_contact
GO
ALTER TABLE patient_master DROP CONSTRAINT IF EXISTS uk_patient_emailaddress
GO
ALTER TABLE patient_master DROP CONSTRAINT IF EXISTS pk_patient_master_id
GO
DROP TABLE IF EXISTS  patient_master
GO

--UP-->Creation of db objects.
CREATE TABLE patient_master (
    patient_id INT IDENTITY NOT NULL,
    patient_firstname VARCHAR(50) NOT NULL,
    patient_lastname VARCHAR(50) NOT NULL,
    patient_dateofbirth DATE NOT NULL,
    patient_phone VARCHAR(10) NOT NULL,
    patient_emailaddress VARCHAR(50) NOT NULL,
    patient_addressline1 VARCHAR(100) NOT NULL,
    patient_addlessline2 VARCHAR(100),
    patient_city VARCHAR(50) NOT NULL,
    patient_state VARCHAR(50) NOT NULL,
    patient_zip INT NOT NULL,
    patient_login_password VARCHAR(15) NOT NULL
    CONSTRAINT pk_patient_master_id PRIMARY KEY (patient_id),
    CONSTRAINT uk_patient_emailaddress UNIQUE(patient_emailaddress))
GO

CREATE TABLE  patient_emergency_contact (
    patient_ec_id INT IDENTITY NOT NULL,
    patient_ec_patient_id INT NOT NULL,
    patient_ec_name VARCHAR(50) NOT NULL,
    patient_ec_phone VARCHAR(10) NOT NULL,
    patient_ec_email_address VARCHAR(50) NOT NULL
    CONSTRAINT pk_patient_emergency_contact_id PRIMARY KEY (patient_ec_id)
    )
GO

CREATE TABLE patient_insurance (
    patient_in_line_id INT IDENTITY NOT NULL,
    patient_in_patient_id INT NOT NULL,
    patient_in_policy_no VARCHAR(100) NOT NULL,
    patient_in_startdate DATE NOT NULL,
    patient_in_expiration_date DATE NOT NULL,
    patient_in_company_name VARCHAR(100) NOT NULL,
    patient_in_copay INT NOT NULL,
    patient_in_med_coverage INT NOT NULL,
    CONSTRAINT pk_patient_in_line_id PRIMARY KEY (patient_in_line_id),
    CONSTRAINT uk_patient_in_policy_no UNIQUE(patient_in_policy_no)
)
GO
CREATE TABLE departments(
    department_code VARCHAR(20) NOT NULL,
    department_name VARCHAR(50) NOT NULL    
    CONSTRAINT pk_department_code PRIMARY KEY (department_code))
GO


CREATE TABLE employee_master(
    employee_id INT IDENTITY NOT NULL,
    employee_designation VARCHAR(50) NOT NULL,
    employee_name VARCHAR(50) NOT NULL,
    employee_dateofbirth DATE NOT NULL,    
    employee_phone VARCHAR(10) NOT NULL,
    employee_emailaddress VARCHAR(50) NOT NULL,    
    employee_hiredate DATE NOT NULL,
    employee_enddate DATE,
    employee_password VARCHAR(50) NOT NULL,
    employee_department VARCHAR(20) NOT NULL,    
    CONSTRAINT pk_employee_master_eid PRIMARY KEY (employee_id),
    CONSTRAINT uk_employee_master_emailaddress UNIQUE (employee_emailaddress)
    )

GO

CREATE TABLE  speciality (
     speciality_code VARCHAR(10) NOT NULL,
     speciality_name VARCHAR(50) NOT NULL,
     CONSTRAINT pk_speciality PRIMARY KEY (speciality_code)
     )
 GO


CREATE TABLE employee_speciality(
    speciality_mapping_id INT IDENTITY NOT NULL,
    speciality_code VARCHAR(10) NOT NULL,
    employee_id INT NOT NULL
    CONSTRAINT pk_employee_speciality PRIMARY KEY (speciality_mapping_id),
    CONSTRAINT fk_emp_spec_id FOREIGN KEY (speciality_code) REFERENCES speciality(speciality_code),
    CONSTRAINT fk_emp_spec_emp_id FOREIGN KEY (employee_id) REFERENCES employee_master(employee_id)
)
CREATE TABLE employee_paychecks(
    emp_paycheck_id INT IDENTITY NOT NULL,
    emp_paycheck_empid INT NOT NULL,
    paycheck_hourly_rate MONEY NOT NULL,
    paycheck_hours_worked FLOAT NOT NULL,
    paycheck_total_compensation MONEY NOT NULL,
    CONSTRAINT pk_paycheck_id PRIMARY KEY (emp_paycheck_id),
    CONSTRAINT fk_emp_paycheck_emp_master FOREIGN KEY (emp_paycheck_empid) REFERENCES employee_master(employee_id)
)

CREATE TABLE room(
    room_no INT NOT NULL,
    room_type VARCHAR(20) NOT NULL,
    room_status VARCHAR(20) NOT NULL,
    room_rate INT NOT NULL,
    room_occupation_start_date DATE,
    room_occupation_end_date DATE,
    room_occupation_number_of_days INT,
    room_patient_id INT
    CONSTRAINT pk_room_no PRIMARY KEY (room_no)
)
GO
CREATE TABLE test(
    test_code VARCHAR(20) NOT NULL,
    test_name VARCHAR(50) NOT NULL,
    test_type VARCHAR(50) NOT NULL,
    test_cost INT NOT NULL,
    CONSTRAINT pk_test_code PRIMARY KEY (test_code)
)
GO
CREATE TABLE  lab_report_results
 (
    lab_report_id INT IDENTITY NOT NULL,
    lab_report_res_test_code VARCHAR(20) NOT NULL,
    lab_report_results_date DATE NOT NULL,
    result_status VARCHAR(50) NOT NULL,
    lab_report_result_description VARCHAR (2000),
    lab_report_rs_patient_id INT NOT NULL,
    lab_report_rs_prescribed_by INT NOT NULL,
    lab_report_rs_generated_by INT,
    CONSTRAINT pk_lab_report_results PRIMARY KEY (lab_report_id)
    )    
GO

CREATE TABLE medicine_master(
    medicine_SKU INT IDENTITY NOT NULL,
    medicine_name VARCHAR(50) NOT NULL,
    medicine_type VARCHAR(50) NOT NULL,
    medicine_description VARCHAR(100),
    medicine_manufacturer VARCHAR(50) NOT NULL,
    CONSTRAINT pk_med_master PRIMARY KEY (medicine_SKU),
    CONSTRAINT uk_medicine_master UNIQUE(medicine_name)
)
GO

CREATE TABLE med_inventory (
    med_inv_line_id INT IDENTITY NOT NULL,
    med_inv_batch_no VARCHAR(10) NOT NULL,
    med_inv_medicine_SKU INT NOT NULL,
    med_inv_quantity_open INT NOT NULL DEFAULT 0,
    med_inv_onhand_quantity INT NOT NULL DEFAULT 0,
    med_inv_mfg_date DATE, 
    med_inv_exp_date DATE,
    med_inv_price MONEY NOT NULL DEFAULT 0
    CONSTRAINT pk_med_inventory_line_id PRIMARY KEY (med_inv_line_id),
    CONSTRAINT fk_med_inv_medicine_SKU FOREIGN KEY (med_inv_medicine_SKU) REFERENCES medicine_master(medicine_SKU)      
    )

GO
CREATE TABLE med_sales (
    med_sales_trac_no INT IDENTITY NOT NULL,
    med_sales_patient_id INT NOT NULL,
    med_sales_medicine_SKU INT NOT NULL,
    med_sales_inv_line_id INT NOT NULL,
    med_sales_quantity INT NOT NULL,
    med_sales_price MONEY NOT NULL,
    med_sales_total_cost MONEY,
    CONSTRAINT pk_med_sales_trac_no PRIMARY KEY (med_sales_trac_no),
    CONSTRAINT fk_med_sales_patient_id FOREIGN KEY (med_sales_patient_id) REFERENCES patient_master(patient_id),
    CONSTRAINT fk_med_sales_med_SKU FOREIGN KEY (med_sales_medicine_SKU) REFERENCES medicine_master(medicine_SKU),
    CONSTRAINT fk_med_sales_line_id FOREIGN KEY (med_sales_inv_line_id) REFERENCES med_inventory(med_inv_line_id)
)
GO

CREATE TABLE med_prescription(
    med_prescription_id INT IDENTITY NOT NULL,
    med_patient_id INT NOT NULL,
    med_prescribed_by_emp_id INT NOT NULL,
    med_medicine_SKU INT,
    med_prescription_morning_dosage FLOAT,
    med_prescription_afternoon_dosage FLOAT,
    med_prescription_evening_dosage FLOAT    
    CONSTRAINT pk_med_prescription_id PRIMARY KEY (med_prescription_id),
    CONSTRAINT fk_med_patient_id FOREIGN KEY (med_patient_id) REFERENCES patient_master(patient_id),
    CONSTRAINT fk_med_prec_emp_id FOREIGN KEY (med_prescribed_by_emp_id) REFERENCES employee_master(employee_id),
    CONSTRAINT fk_med_prec_medSKU FOREIGN KEY (med_medicine_SKU) REFERENCES med_inventory(med_inv_line_id)
)
GO
 CREATE TABLE billing(
     bill_no INT IDENTITY NOT NULL,
     bill_patient_id INT NOT NULL,
     bii_total_amount MONEY
     CONSTRAINT pk_bill_no PRIMARY KEY (bill_no),
     CONSTRAINT fk_bill_patient_id FOREIGN KEY (bill_patient_id) REFERENCES patient_master(patient_id)     
 )
GO

--UP Metadata --> Creation of metadata like constraint on the db objects.
ALTER TABLE patient_emergency_contact 
ADD CONSTRAINT fk_patient_ec_patient_id 
FOREIGN KEY (patient_ec_patient_id) REFERENCES patient_master(patient_id)
GO
ALTER TABLE patient_insurance
ADD CONSTRAINT fk_patient_insurance_pid
FOREIGN KEY (patient_in_patient_id) REFERENCES patient_master(patient_id)
GO

GO
ALTER TABLE employee_master
ADD CONSTRAINT fk_employee_dept_id
FOREIGN KEY (employee_department) REFERENCES departments(department_code)
GO
ALTER TABLE room
ADD CONSTRAINT fk_room_patient_id
FOREIGN KEY(room_patient_id) REFERENCES patient_master(patient_id)
GO
ALTER TABLE lab_report_results
ADD CONSTRAINT fk_lab_report_result_patient
FOREIGN KEY (lab_report_rs_patient_id) REFERENCES patient_master(patient_id)
GO
ALTER TABLE lab_report_results
ADD CONSTRAINT fk_lab_report_result_prescribed_by
FOREIGN KEY (lab_report_rs_prescribed_by) REFERENCES employee_master(employee_id)
GO
ALTER TABLE lab_report_results
ADD CONSTRAINT fk_lab_report_result_generated_by
FOREIGN KEY (lab_report_rs_generated_by) REFERENCES employee_master(employee_id)
GO
ALTER TABLE lab_report_results
ADD CONSTRAINT fk_lab_report_result_test_code
FOREIGN KEY (lab_report_res_test_code) REFERENCES test(test_code)
GO