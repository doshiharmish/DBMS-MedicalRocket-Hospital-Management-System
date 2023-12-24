USE medicalrocket
--DOWN-->Dropping db objects mentioned in the UP section
DROP PROCEDURE IF EXISTS proc_patient_report_results
GO
DROP PROCEDURE IF EXISTS proc_lab_prescription
GO
DROP VIEW IF EXISTS v_patient_lab_test_records
GO
DROP VIEW IF EXISTS v_patient_details
GO
--UP-->Creation of db objects.
CREATE VIEW v_patient_details
AS
SELECT p.patient_id,p.patient_firstname +' '+p.patient_lastname AS "Patient_Name",p.patient_dateofbirth AS "Date_of_Birth",R.room_no AS "Room_Number",R.room_occupation_start_date AS "Admission_Date"
FROM patient_master P
LEFT JOIN room r ON p.patient_id = r.room_patient_id
GO
CREATE VIEW v_patient_lab_test_records
AS
SELECT l.lab_report_id,l.lab_report_rs_patient_id,p.patient_firstname +' '+p.patient_lastname AS "Patient_Name",p.patient_emailaddress,t.test_name,t.test_type,t.test_cost,l.lab_report_results_date,l.result_status,l.lab_report_result_description,e.employee_name
FROM lab_report_results l
JOIN test t ON t.test_code = l.lab_report_res_test_code
LEFT JOIN employee_master e ON e.employee_id = l.lab_report_rs_generated_by
JOIN patient_master p ON p.patient_id = l.lab_report_rs_patient_id
GO

CREATE PROCEDURE proc_lab_prescription(
    @in_test_code VARCHAR(20),
    @in_patient_id INT,
    @in_employee_emailaddress VARCHAR(100)
)
AS 
DECLARE @in_employee_id INT
BEGIN

    --BEGIN TRY
        BEGIN TRANSACTION
            
            IF(@in_test_code IS NOT NULL AND @in_patient_id IS NOT NULL AND @in_employee_emailaddress IS NOT NULL)
            BEGIN
            
        SELECT @in_employee_id = e.employee_id  FROM employee_master e WHERE e.employee_emailaddress = @in_employee_emailaddress
        
        INSERT INTO lab_report_results
                 (
                    lab_report_res_test_code,
                    lab_report_results_date,
                    result_status,
                    lab_report_rs_patient_id,
                    lab_report_rs_prescribed_by      
                )
    VALUES
        (
            @in_test_code,
            CONVERT(date,GETDATE()),
            'prescribed',
            @in_patient_id,            
            @in_employee_id           
        )

            END
            COMMIT
      --  END TRY
END
GO
CREATE PROCEDURE proc_patient_report_results(
    @in_lab_report_id INT,
    @in_patient_id INT,
    @in_employee_emailaddress VARCHAR(100),
    @in_test_result VARCHAR(2000)
    )AS
DECLARE @in_employee_id INT
BEGIN

    --BEGIN TRY
        BEGIN TRANSACTION
            
            IF(@in_lab_report_id IS NOT NULL AND @in_patient_id IS NOT NULL AND @in_employee_emailaddress IS NOT NULL AND @in_test_result IS NOT NULL)
            BEGIN
            
        SELECT @in_employee_id = e.employee_id  FROM employee_master e WHERE e.employee_emailaddress = @in_employee_emailaddress
        
        UPDATE lab_report_results
                SET 
                    lab_report_results_date = CONVERT(date,GETDATE()),
                    result_status = 'generated',
                    lab_report_result_description = @in_test_result,
                    lab_report_rs_generated_by  = @in_employee_id
                    WHERE  lab_report_rs_patient_id = @in_patient_id
                    AND lab_report_id = @in_lab_report_id
                                

            END
            COMMIT
      --  END TRY
END