-- -----------------------------------------------------
-- Data for table services
-- -----------------------------------------------------

INSERT INTO services (service_id, name) VALUES (1000, 'Gift Shop');
INSERT INTO services (service_id, name) VALUES (1010, 'Flourist');
INSERT INTO services (service_id, name) VALUES (1020, 'Cafeteria');
INSERT INTO services (service_id, name) VALUES (1030, 'X Ray');
INSERT INTO services (service_id, name) VALUES (1040, 'Spinal Tap');
INSERT INTO services (service_id, name) VALUES (1050, 'Minor Surgery');
INSERT INTO services (service_id, name) VALUES (1060, 'Major Surgery');
INSERT INTO services (service_id, name) VALUES (1070, 'Blood Transfusion');
INSERT INTO services (service_id, name) VALUES (1080, 'Evaluation');
INSERT INTO services (service_id, name) VALUES (1090, 'Checkup');
INSERT INTO services (service_id, name) VALUES (1100, 'Rehabilitation');
INSERT INTO services (service_id, name) VALUES (1110, 'Eye Exam');
INSERT INTO services (service_id, name) VALUES (1120, 'Blood Work');
INSERT INTO services (service_id, name) VALUES (1130, 'Counseling');
INSERT INTO services (service_id, name) VALUES (1140, 'MRI');
INSERT INTO services (service_id, name) VALUES (1150, 'Information Desk');
INSERT INTO services (service_id, name) VALUES (1160, 'Emergency');
INSERT INTO services (service_id, name) VALUES (1170, 'Childbirth');

-- -----------------------------------------------------
-- Data for table inpatient
-- -----------------------------------------------------

INSERT INTO inpatient (service_id) VALUES (1040);
INSERT INTO inpatient (service_id) VALUES (1050);
INSERT INTO inpatient (service_id) VALUES (1060);
INSERT INTO inpatient (service_id) VALUES (1070);
INSERT INTO inpatient (service_id) VALUES (1160);
INSERT INTO inpatient (service_id) VALUES (1170);

-- -----------------------------------------------------
-- Data for table outpatient
-- -----------------------------------------------------

INSERT INTO outpatient (service_id) VALUES (1080);
INSERT INTO outpatient (service_id) VALUES (1090);
INSERT INTO outpatient (service_id) VALUES (1100);
INSERT INTO outpatient (service_id) VALUES (1110);
INSERT INTO outpatient (service_id) VALUES (1120);
INSERT INTO outpatient (service_id) VALUES (1130);
INSERT INTO outpatient (service_id) VALUES (1030);

-- -----------------------------------------------------
-- Data for table nonmedical
-- -----------------------------------------------------

INSERT INTO nonmedical (service_id) VALUES (1000);
INSERT INTO nonmedical (service_id) VALUES (1010);
INSERT INTO nonmedical (service_id) VALUES (1020);
INSERT INTO nonmedical (service_id) VALUES (1150);

-- -----------------------------------------------------
-- Data for table workers
-- -----------------------------------------------------

INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1000, 'Bob', 'Johnson', '2013-03-01');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1001, 'Jane', 'Smith', '2014-01-07');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1002, 'Steve', 'Wilson', '2010-02-03');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1003, 'Cathy', 'Davis', '2008-05-09');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1004, 'Mike', 'Hughes', '2009-06-11');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1005, 'Kate', 'Yates', '2006-04-01');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1006, 'Jeff', 'Payne', '2012-08-14');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1007, 'Carl', 'Morgan', '2007-09-22');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1008, 'Rick', 'Ward', '2003-11-11');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1009, 'Nancy', 'Bates', '2001-08-28');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1010, 'Charles', 'Babbage', '2002-05-05');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1011, 'Alan', 'Turing', '2004-03-19');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1012, 'Larry', 'Wall', '2007-07-09');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1013, 'Edgar', 'Codd', '2002-02-02');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1014, 'Grace', 'Hopper', '2003-06-27');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1015, 'James', 'Gosling', '2001-03-04');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1016, 'Charles', 'Bachman', '2001-06-08');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1017, 'Gordon', 'Bell', '2002-09-09');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1018, 'Peter', 'Chen', '2004-10-31');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1019, 'Ada', 'Lovelace', '2006-03-11');
INSERT INTO workers (worker_id, fname, lname, hire_date) VALUES (1020, 'Donald', 'Knuth', '2007-07-04');

-- -----------------------------------------------------
-- Data for table volunteers
-- -----------------------------------------------------

INSERT INTO volunteers (volunteer_id) VALUES (1003);
INSERT INTO volunteers (volunteer_id) VALUES (1007);
INSERT INTO volunteers (volunteer_id) VALUES (1011);
INSERT INTO volunteers (volunteer_id) VALUES (1009);
INSERT INTO volunteers (volunteer_id) VALUES (1006);
INSERT INTO volunteers (volunteer_id) VALUES(1004);
INSERT INTO volunteers (volunteer_id) VALUES(1013);
INSERT INTO volunteers (volunteer_id) VALUES(1016);

-- -----------------------------------------------------
-- Data for table employees
-- -----------------------------------------------------

INSERT INTO employees (employee_id) VALUES (1001);
INSERT INTO employees (employee_id) VALUES (1002);
INSERT INTO employees (employee_id) VALUES (1004);
INSERT INTO employees (employee_id) VALUES (1005);
INSERT INTO employees (employee_id) VALUES (1008);
INSERT INTO employees (employee_id) VALUES (1010);
INSERT INTO employees (employee_id) VALUES (1011);
INSERT INTO employees (employee_id) VALUES (1012);
INSERT INTO employees (employee_id) VALUES (1013);
INSERT INTO employees (employee_id) VALUES (1014);
INSERT INTO employees (employee_id) VALUES (1015);
INSERT INTO employees (employee_id) VALUES (1016);
INSERT INTO employees (employee_id) VALUES (1017);
INSERT INTO employees (employee_id) VALUES (1018);
INSERT INTO employees (employee_id) VALUES (1019);
INSERT INTO employees (employee_id) VALUES (1020);

-- -----------------------------------------------------
-- Data for table treatment_administrator
-- -----------------------------------------------------

INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1000);
INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1001);
INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1002);
INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1003);
INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1004);
INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1005);
INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1006);
INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1007);
INSERT INTO treatment_administrator (treatment_admin_id) VALUES (1008);

-- -----------------------------------------------------
-- Data for table nurses
-- -----------------------------------------------------

INSERT INTO nurses (nurse_id, treatment_admin_id) VALUES (1004, 1000);
INSERT INTO nurses (nurse_id, treatment_admin_id) VALUES (1005, 1001);

-- -----------------------------------------------------
-- Data for table administrators
-- -----------------------------------------------------

INSERT INTO administrators (administrator_id) VALUES (1013);
INSERT INTO administrators (administrator_id) VALUES (1016);
INSERT INTO administrators (administrator_id) VALUES (1018);
INSERT INTO administrators (administrator_id) VALUES (1020);

-- -----------------------------------------------------
-- Data for table technicians
-- -----------------------------------------------------

INSERT INTO technicians (technician_id, treatment_admin_id) VALUES (1001, 1003);
INSERT INTO technicians (technician_id, treatment_admin_id) VALUES (1002, NULL);
INSERT INTO technicians (technician_id, treatment_admin_id) VALUES (1008, 1004);
INSERT INTO technicians (technician_id, treatment_admin_id) VALUES (1011, NULL);

-- -----------------------------------------------------
-- Data for table staff
-- -----------------------------------------------------

INSERT INTO staff (staff_id) VALUES (1017);
INSERT INTO staff (staff_id) VALUES (1019);
INSERT INTO staff (staff_id) VALUES (1002);
INSERT INTO staff (staff_id) VALUES (1004);

-- -----------------------------------------------------
-- Data for table doctors
-- -----------------------------------------------------

INSERT INTO doctors (doctor_id, treatment_admin_id) VALUES (1008, 1005);
INSERT INTO doctors (doctor_id, treatment_admin_id) VALUES (1010, NULL);
INSERT INTO doctors (doctor_id, treatment_admin_id) VALUES (1012, 1006);
INSERT INTO doctors (doctor_id, treatment_admin_id) VALUES (1014, 1007);
INSERT INTO doctors (doctor_id, treatment_admin_id) VALUES (1015, NULL);
INSERT INTO doctors (doctor_id) VALUES(1019);
INSERT INTO doctors (doctor_id) VALUES(1016);
INSERT INTO doctors (doctor_id) VALUES(1018);

-- -----------------------------------------------------
-- Data for table patients
-- -----------------------------------------------------

INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1000, 'Issac', 'Newton', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1001, 'Leonardo', 'Fibonacci', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1002, 'Albert', 'Einstein', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1003, 'Neils ', 'Bohr', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1004, 'Robert', 'Oppenheimer', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1005, 'Enrico', 'Fermi', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1006, 'Marie', 'Curie', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1007, 'Stephen', 'Hawking', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1008, 'Max', 'Planck', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1009, 'Nikola', 'Tesla', NULL, NULL);
INSERT INTO patients (patient_id, fname, lname, policynum, contact) VALUES (1010, 'Guglielmo', 'Marconi', NULL, NULL);

-- -----------------------------------------------------
-- Data for table diagnoses
-- -----------------------------------------------------

INSERT INTO diagnoses (diagnosis_id, name) VALUES (1000, 'Common Cold');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1010, 'Gangrene');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1020, 'Chicken Pox');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1030, 'Brain Damage');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1040, 'Jaundice');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1050, 'Food Poisoning');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1060, 'Hypochondria');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1070, 'Scoliosis');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1080, 'Carpal Tunnel Syndrome');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1090, 'Blindness');
INSERT INTO diagnoses (diagnosis_id, name) VALUES (1100, 'Hearing Loss');
INSERT INTO diagnoses (diagnosis_id, name) VALUES(1110, 'Heart Attack');


-- -----------------------------------------------------
-- Data for table admissions
-- -----------------------------------------------------


-- -----------------------------------------------------
-- Data for table treatments
-- -----------------------------------------------------

INSERT INTO treatments (treatment_id, name, type) VALUES (1001, 'Amputation', 'procedure');
INSERT INTO treatments (treatment_id, name, type) VALUES (1002, 'Leaches', 'procedure');
INSERT INTO treatments (treatment_id, name, type) VALUES (1003, 'Epidural', 'procedure');
INSERT INTO treatments (treatment_id, name, type) VALUES (1004, 'Intravenous Drip', 'medication');
INSERT INTO treatments (treatment_id, name, type) VALUES (1005, 'Organ Removal','procedure');
INSERT INTO treatments (treatment_id, name, type) VALUES (1006, 'Electric Shock', 'procedure');
INSERT INTO treatments (treatment_id, name, type) VALUES (1007, 'Cast', 'procedure');
INSERT INTO treatments (treatment_id, name, type) VALUES (1008, 'Anesthesia', 'medication');


-- -----------------------------------------------------
-- Data for table volunteer_schedules
-- -----------------------------------------------------

INSERT INTO volunteer_schedules (volunteer_id, service_id, day) VALUES (1003, 1010, 'Monday');
INSERT INTO volunteer_schedules (volunteer_id, service_id, day) VALUES (1007, 1000, 'Wednesday');
INSERT INTO volunteer_schedules (volunteer_id, service_id, day) VALUES (1009, 1010, 'Tuesday');
INSERT INTO volunteer_schedules (volunteer_id, service_id, day) VALUES (1011, 1020, 'Friday');
INSERT INTO volunteer_schedules (volunteer_id, service_id, day) VALUES (1006, 1000, 'Tuesday');

-- -----------------------------------------------------
-- Data for table staff_assignments
-- -----------------------------------------------------

INSERT INTO staff_assignments (staff_id, service_id) VALUES(1017,1000);
INSERT INTO staff_assignments (staff_id, service_id) VALUES(1019,1020);
INSERT INTO staff_assignments (staff_id, service_id) VALUES(1017,1150);
INSERT INTO staff_assignments (staff_id, service_id) VALUES(1004,1010);

-- -----------------------------------------------------
-- Data for table outpatients
-- -----------------------------------------------------

INSERT INTO outpatients (outpatient_id, doctor_id, patient_id, service_id, diagnosis_id, start_date, end_date) VALUES(NULL, 1015, 1002, 1030, 1090, '2015-03-04', '2015-03-06');

-- -----------------------------------------------------
-- Data for table outpatient_orders
-- -----------------------------------------------------



-- -----------------------------------------------------
-- Data for table admissions
-- -----------------------------------------------------

INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1000, 1010, 1000, 1070, 1000, '2015-05-22');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1001, 1012, 1001, 1060, 1030, '2015-01-21');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1002, 1015, 1005, 1160, 1080, '2015-04-12');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1003, 1019, 1008, 1160, 1050, '2015-03-15');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1004, 1014, 1004, 1050, 1070, '2015-02-05');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1005, 1018, 1010, 1160, 1010, '2015-04-01');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1006, 1010, 1002, 1060, 1060, '2015-06-30');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1007, 1012, 1007, 1070, 1020, '2015-07-07');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1008, 1016, 1003, 1160, 1040, '2015-07-10');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1009, 1008, 1006, 1060, 1070, '2015-07-08');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1010, 1018, 1002, 1160, 1080, '2015-07-02');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1011, 1014, 1006, 1060, 1050, '2015-07-10');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1012, 1010, 1008, 1060, 1100, '2015-06-08');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1013, 1018, 1007, 1050, 1020, '2015-07-05');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1014, 1019, 1000, 1070, 1110, '2015-07-09');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1015, 1012, 1002, 1160, 1030, '2015-07-09');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1016, 1008, 1010, 1060, 1010, '2015-05-06');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1017, 1018, 1003, 1060, 1110, '2015-04-05');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1018, 1012, 1001, 1160, 1000, '2015-06-07');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1019, 1019, 1005, 1160, 1050, '2015-03-08');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1020, 1010, 1010, 1040, 1070, '2015-01-04');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1021, 1015, 1006, 1170, 1060, '2015-02-02');
INSERT INTO admissions (admission_id, doctor_id, patient_id, service_id, diagnosis_id, timestamp) VALUES(1022, 1014, 1002, 1070, 1020, '2015-03-21');


-- -----------------------------------------------------
-- Data for table rooms
-- -----------------------------------------------------

INSERT INTO rooms (room_id) VALUES ('1112A');
INSERT INTO rooms (room_id) VALUES ('1023B');
INSERT INTO rooms (room_id) VALUES ('1044A');
INSERT INTO rooms (room_id) VALUES ('2040C');
INSERT INTO rooms (room_id) VALUES ('2153A');
INSERT INTO rooms (room_id) VALUES ('2223A');
INSERT INTO rooms (room_id) VALUES ('3122B');
INSERT INTO rooms (room_id) VALUES ('3012B');
INSERT INTO rooms (room_id) VALUES ('3011D');


-- -----------------------------------------------------
-- Room assignment updates
-- -----------------------------------------------------

UPDATE rooms SET admission_id = 1008 WHERE room_id = '1112A';
UPDATE rooms SET admission_id = 1009 WHERE room_id = '2011B';
UPDATE rooms SET admission_id = 1010 WHERE room_id = '4111B';
UPDATE rooms SET admission_id = 1011 WHERE room_id = '2011B';
UPDATE rooms SET admission_id = 1012 WHERE room_id = '1044A';
UPDATE rooms SET admission_id = 1013 WHERE room_id = '2153A';
UPDATE rooms SET admission_id = 1014 WHERE room_id = '3122B';
UPDATE rooms SET admission_id = 1015 WHERE room_id = '2223A';
UPDATE rooms SET admission_id = 1006 WHERE room_id = '1044A';
UPDATE rooms SET admission_id = 1008 WHERE room_id = '2153A';
UPDATE rooms SET admission_id = 1009 WHERE room_id = '3122B';
UPDATE rooms SET admission_id = 1010 WHERE room_id = '2153A';

-- -----------------------------------------------------
-- Data for table assigned_doctors
-- PRIMARY DOCTOR \ ADMISSION INSERT HANDLED BY TRIGGER
-- -----------------------------------------------------

#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1010, 1000, 1001);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1012, 1001, 1001);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1015, 1002, 1002);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1019, 1003, 1003);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1014, 1004, 1004);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1018, 1005, 1005);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1010, 1006, 1006);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1012, 1007, 1007);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1016, 1008, 1008);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1008, 1009, 1009);
#INSERT INTO assigned_doctors (doctor_id, admission_id, assignment_id) VALUES(1018, 1010, 1009);

-- -----------------------------------------------------
-- Data for table orders
-- -----------------------------------------------------



-- -----------------------------------------------------
-- Data for table administered_treatments
-- -----------------------------------------------------



-- -----------------------------------------------------
-- Data for table discharges
-- -----------------------------------------------------

INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1001, 1013, NULL);
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1000, 1013, NULL);
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1002, 1016, NULL);
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1003, 1013, NULL);
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1004, 1013, NULL);
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1005, 1013, NULL);
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1007, 1013, NULL);
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1016, 1013, '2015-05-15');
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1017, 1013, '2015-04-12');
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1018, 1018, '2015-06-15');
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1019, 1018, '2015-03-15');
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1020, 1016, '2015-01-24');
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1022, 1013, '2015-02-12');
INSERT INTO discharges (admission_id, administrators_id, timestamp) VALUES(1021, 1020, '2015-03-28');

