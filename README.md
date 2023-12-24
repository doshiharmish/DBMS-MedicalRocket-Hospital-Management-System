# MedicalRocket
## Overview:
This user-friendly system tackles the challenge of managing diverse hospital data by centralizing information and empowering stakeholders with intuitive access.

## Key Features & Objectives
- **Efficient Administration Management:** Streamline the management of employees and patients, enhancing administrative efficiency.
- **Unified Medical Records:** Grant patients and authorized personnel secure access to comprehensive medical data.
- **Medicine Inventory Tracking:** Keep precise track of medicines sold by the hospital store, ensuring accurate inventory management.

## Project Execution
- **Data Collection and Entity Identification:** Identified entities and relationships, documented in the ER-Data requirements sheet.
- **Conceptual and Logical Model Design:** Developed using draw.io to visualize the relationships.

***Conceptual Model:***
  
  ![Conceptual_Diagram](https://github.com/doshiharmish/MedicalRocket/assets/16878994/912ce7a9-44cb-4fcf-b824-ccde89aca53d)


  ***Logical Model:***
  
  ![Logical_Model](https://github.com/doshiharmish/MedicalRocket/assets/16878994/71e27217-02a5-4eb7-bd08-285be2a37c85)


  
- **Database Implementation:** Executed SQL scripts based on the designed models to create the database structure.
- **User Interface Creation:** Utilized Microsoft PowerApps to create a flexible and user-friendly interface.  For a detailed visual representation of the proposed application screens, please refer to the attached 'medical_rocket_screens.pdf' file.


## Execution Flow for DBMS Files:
Table Creation Script: Run Table_Creation_Script.sql to generate the database structure.
Data Logic Scripts: Execute Data_Logic_scripts.sql to implement data logic and functionalities.
Values Insertion Scripts: Use Values_Insert_Scripts.sql to populate the database with initial or sample data values.

## Implemented User Stories
### User Story 1: Doctor Prescribing Lab Tests
Using Power Apps, we created a user story allowing doctors to prescribe lab tests. Here's the process:

1. Doctor Login: After logging in with their credentials, the doctor navigates to the employee section.
2. Patient List Display: The doctor views a list of patients and selects a patient to prescribe tests.
3. Test Prescription: The doctor prescribes necessary tests from the patient's profile.
4. Procedure Invocation: Upon form submission, a procedure is triggered via Microsoft Automate Flow, supporting the prescription process.

![image](https://github.com/doshiharmish/MedicalRocket/assets/16878994/55529117-14e1-453d-94f3-a296a193a59a)


### User Story 2: Lab Technician Generating Lab Results
For lab technicians to generate lab results, we crafted a user story within Power Apps along with relevant procedures:
1. Lab Technician Login: The lab technician accesses the employee section after authentication.
2. Patient Test List: A list of patients prescribed tests by doctors is displayed.
3. Result Generation: The lab technician accesses patient test details and generates test results.
4. Procedure Execution: Similar to the doctor's scenario, submitting the form triggers a procedure via Microsoft Automate Flow, enabling result generation.

![image](https://github.com/doshiharmish/MedicalRocket/assets/16878994/7e5ff571-6b48-4371-a5a7-d2177ce0708f)


### User Story 3: Patient Viewing Lab Results
Patients can conveniently view their lab results through Power Apps, supported by a created view:
1. Patient Login: Patients log in using their credentials, accessing the patient section.
2. Result Display: Patients view the results of lab tests prescribed by doctors from their profiles.
3. Accessibility: Lab results are displayed for the patient's perusal.
4. Automate Flow Trigger: Upon form submission, a process facilitated by Microsoft Automate Flow allows access to the desired lab results.


![image](https://github.com/doshiharmish/MedicalRocket/assets/16878994/2702cc6a-3b7e-4670-9503-bbac9cf57602)


## Assumptions
- **Universal Insurance Coverage:** All patients admitted to the hospital are assumed to possess comprehensive insurance coverage, ensuring comprehensive medical support.
- **Medication Procurement:** We have assumed that all prescribed medications are exclusively sourced from the hospital's store. This ensures consistent and controlled access to medicines for patient treatment.
