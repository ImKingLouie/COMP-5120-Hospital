-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS hospital ;
CREATE SCHEMA IF NOT EXISTS hospital;
USE hospital ;

-- -----------------------------------------------------
-- Table services
-- -----------------------------------------------------
DROP TABLE IF EXISTS services;

CREATE TABLE IF NOT EXISTS services (
  service_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NULL,
  PRIMARY KEY (service_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table inpatient
-- -----------------------------------------------------
DROP TABLE IF EXISTS inpatient ;

CREATE TABLE IF NOT EXISTS inpatient (
  service_id INT NOT NULL,
  PRIMARY KEY (service_id),
  FOREIGN KEY (service_id) REFERENCES services (service_id));

-- -----------------------------------------------------
-- Table outpatient
-- -----------------------------------------------------
DROP TABLE IF EXISTS outpatient ;

CREATE TABLE IF NOT EXISTS outpatient (
  service_id INT NOT NULL,
  PRIMARY KEY (service_id),
  FOREIGN KEY (service_id) REFERENCES services (service_id));

-- -----------------------------------------------------
-- Table nonmedical
-- -----------------------------------------------------
DROP TABLE IF EXISTS nonmedical ;

CREATE TABLE IF NOT EXISTS nonmedical (
  service_id INT NOT NULL,
  PRIMARY KEY (service_id),
  FOREIGN KEY (service_id) REFERENCES services (service_id));

-- -----------------------------------------------------
-- Table workers
-- -----------------------------------------------------
DROP TABLE IF EXISTS workers ;

CREATE TABLE IF NOT EXISTS workers (
  worker_id INT NOT NULL AUTO_INCREMENT,
  fname VARCHAR(45) NOT NULL,
  lname VARCHAR(45) NOT NULL,
  hire_date DATE NOT NULL,
  PRIMARY KEY (worker_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table volunteers
-- -----------------------------------------------------
DROP TABLE IF EXISTS volunteers ;

CREATE TABLE IF NOT EXISTS volunteers (
  volunteer_id INT NOT NULL,
  PRIMARY KEY (volunteer_id),
  FOREIGN KEY (volunteer_id) REFERENCES workers (worker_id));

-- -----------------------------------------------------
-- Table employees
-- -----------------------------------------------------
DROP TABLE IF EXISTS employees ;

CREATE TABLE IF NOT EXISTS employees (
  employee_id INT NOT NULL,
  PRIMARY KEY (employee_id),
  FOREIGN KEY (employee_id) REFERENCES workers (worker_id));

-- -----------------------------------------------------
-- Table treatment_administrator
-- -----------------------------------------------------
DROP TABLE IF EXISTS treatment_administrator ;

CREATE TABLE IF NOT EXISTS treatment_administrator (
  treatment_admin_id INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (treatment_admin_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table nurses
-- -----------------------------------------------------
DROP TABLE IF EXISTS nurses ;

CREATE TABLE IF NOT EXISTS nurses (
  nurse_id INT NOT NULL,
  treatment_admin_id INT NULL,
  PRIMARY KEY (nurse_id),
  FOREIGN KEY (nurse_id) REFERENCES employees (employee_id),
  FOREIGN KEY (treatment_admin_id) REFERENCES treatment_administrator (treatment_admin_id));

-- -----------------------------------------------------
-- Table administrators
-- -----------------------------------------------------
DROP TABLE IF EXISTS administrators ;

CREATE TABLE IF NOT EXISTS administrators (
  administrator_id INT NOT NULL,
  PRIMARY KEY (administrator_id),
  FOREIGN KEY (administrator_id) REFERENCES employees (employee_id));

-- -----------------------------------------------------
-- Table technicians
-- -----------------------------------------------------
DROP TABLE IF EXISTS technicians ;

CREATE TABLE IF NOT EXISTS technicians (
  technician_id INT NOT NULL,
  treatment_admin_id INT NULL,
  PRIMARY KEY (technician_id),
  FOREIGN KEY (technician_id) REFERENCES employees (employee_id),
  FOREIGN KEY (treatment_admin_id) REFERENCES treatment_administrator (treatment_admin_id));

-- -----------------------------------------------------
-- Table staff
-- -----------------------------------------------------
DROP TABLE IF EXISTS staff ;

CREATE TABLE IF NOT EXISTS staff (
  staff_id INT NOT NULL,
  PRIMARY KEY (staff_id),
  FOREIGN KEY (staff_id) REFERENCES employees (employee_id));

-- -----------------------------------------------------
-- Table doctors
-- -----------------------------------------------------
DROP TABLE IF EXISTS doctors ;

CREATE TABLE IF NOT EXISTS doctors (
  doctor_id INT NOT NULL,
  treatment_admin_id INT NULL,
  PRIMARY KEY (doctor_id),
  FOREIGN KEY (doctor_id) REFERENCES employees (employee_id),
  FOREIGN KEY (treatment_admin_id) REFERENCES treatment_administrator (treatment_admin_id));

-- -----------------------------------------------------
-- Table patients
-- -----------------------------------------------------
DROP TABLE IF EXISTS patients;

CREATE TABLE IF NOT EXISTS patients (
  patient_id INT NOT NULL AUTO_INCREMENT,
  fname VARCHAR(45) NOT NULL,
  lname VARCHAR(45) NOT NULL,
  policynum VARCHAR(45) NULL,
  contact VARCHAR(45) NULL,
  PRIMARY KEY (patient_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table diagnoses
-- -----------------------------------------------------
DROP TABLE IF EXISTS diagnoses;

CREATE TABLE IF NOT EXISTS diagnoses (
  diagnosis_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NULL,
  PRIMARY KEY (diagnosis_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table admissions
-- -----------------------------------------------------
DROP TABLE IF EXISTS admissions;

CREATE TABLE IF NOT EXISTS admissions (
  admission_id INT NOT NULL AUTO_INCREMENT,
  doctor_id INT NOT NULL,
  patient_id INT NOT NULL,
  service_id INT NOT NULL,
  diagnosis_id INT NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (admission_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id),
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (service_id) REFERENCES inpatient (service_id),
  FOREIGN KEY (diagnosis_id) REFERENCES diagnoses (diagnosis_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table assigned_doctors
-- -----------------------------------------------------
DROP TABLE IF EXISTS assigned_doctors ;

CREATE TABLE IF NOT EXISTS assigned_doctors (
  doctor_id INT NOT NULL,
  admission_id INT NOT NULL,
  assignment_id INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (doctor_id, admission_id),
  UNIQUE INDEX assignment_id_UNIQUE (assignment_id ASC),
  FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id),
  FOREIGN KEY (admission_id) REFERENCES admissions (admission_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table treatments
-- -----------------------------------------------------
DROP TABLE IF EXISTS treatments ;

CREATE TABLE IF NOT EXISTS treatments (
  treatment_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  type ENUM('procedure','medication') NOT NULL,
  PRIMARY KEY (treatment_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table orders
-- -----------------------------------------------------
DROP TABLE IF EXISTS orders ;

CREATE TABLE IF NOT EXISTS orders (
  order_id INT NOT NULL AUTO_INCREMENT,
  assignment_id INT NOT NULL,
  treatment_admin_id INT NOT NULL,
  treatment_id INT NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id, treatment_admin_id, treatment_id, assignment_id),
  FOREIGN KEY (treatment_id) REFERENCES treatments (treatment_id),
  FOREIGN KEY (treatment_admin_id) REFERENCES treatment_administrator (treatment_admin_id),
  FOREIGN KEY (assignment_id) REFERENCES assigned_doctors (assignment_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table administered_treatments
-- -----------------------------------------------------
DROP TABLE IF EXISTS administered_treatments ;

CREATE TABLE IF NOT EXISTS administered_treatments (
  order_id INT NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id),
  FOREIGN KEY (order_id) REFERENCES orders (order_id));

-- -----------------------------------------------------
-- Table rooms
-- -----------------------------------------------------
DROP TABLE IF EXISTS rooms ;

CREATE TABLE IF NOT EXISTS rooms (
  room_id VARCHAR(8) NOT NULL,
  admission_id INT NULL,
  PRIMARY KEY (room_id),
  FOREIGN KEY (admission_id) REFERENCES admissions (admission_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table volunteer_schedules
-- -----------------------------------------------------
DROP TABLE IF EXISTS volunteer_schedules ;

CREATE TABLE IF NOT EXISTS volunteer_schedules (
  volunteer_id INT NOT NULL,
  service_id INT NOT NULL,
  day ENUM('sunday', 'monday','tuesday','wednesday','thursday','friday','saturday') NULL,
  PRIMARY KEY (volunteer_id, service_id),
  FOREIGN KEY (volunteer_id) REFERENCES volunteers (volunteer_id),
  FOREIGN KEY (service_id) REFERENCES nonmedical (service_id));

-- -----------------------------------------------------
-- Table staff_assignments
-- -----------------------------------------------------
DROP TABLE IF EXISTS staff_assignments ;

CREATE TABLE IF NOT EXISTS staff_assignments (
  staff_id INT NOT NULL,
  service_id INT NOT NULL,
  PRIMARY KEY (staff_id, service_id),
  FOREIGN KEY (staff_id) REFERENCES staff (staff_id),
  FOREIGN KEY (service_id) REFERENCES nonmedical (service_id));

-- -----------------------------------------------------
-- Table outpatients
-- -----------------------------------------------------
DROP TABLE IF EXISTS outpatients ;

CREATE TABLE IF NOT EXISTS outpatients (
  outpatient_id INT NOT NULL AUTO_INCREMENT,
  doctor_id INT NOT NULL,
  patient_id INT NOT NULL,
  service_id INT NOT NULL,
  diagnosis_id INT NOT NULL,
  start_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  end_date TIMESTAMP NULL,
  PRIMARY KEY (outpatient_id, doctor_id, patient_id, service_id, diagnosis_id),
  FOREIGN KEY (service_id) REFERENCES outpatient (service_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id),
  FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
  FOREIGN KEY (diagnosis_id) REFERENCES diagnoses (diagnosis_id));

-- -----------------------------------------------------
-- Table discharges
-- -----------------------------------------------------
DROP TABLE IF EXISTS discharges ;

CREATE TABLE IF NOT EXISTS discharges (
  admission_id INT NOT NULL,
  administrators_id INT NOT NULL,
  timestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (admission_id, administrators_id),
  FOREIGN KEY (admission_id) REFERENCES admissions (admission_id),
  FOREIGN KEY (administrators_id) REFERENCES administrators (administrator_id));

-- -----------------------------------------------------
-- Table outpatient_orders
-- -----------------------------------------------------
DROP TABLE IF EXISTS outpatient_orders ;

CREATE TABLE IF NOT EXISTS outpatient_orders (
  order_id INT NOT NULL AUTO_INCREMENT,
  outpatient_id INT NOT NULL,
  treatment_admin_id INT NOT NULL,
  treatment_id INT NOT NULL,
  timestamp TIMESTAMP NOT NULL,
  PRIMARY KEY (order_id, outpatient_id, treatment_id, treatment_admin_id),
  FOREIGN KEY (outpatient_id) REFERENCES outpatients (outpatient_id),
  FOREIGN KEY (treatment_admin_id) REFERENCES treatment_administrator (treatment_admin_id),
  FOREIGN KEY (treatment_id) REFERENCES treatments (treatment_id))
  AUTO_INCREMENT = 1000;

-- -----------------------------------------------------
-- Table administered_outpatient_treatments
-- -----------------------------------------------------
DROP TABLE IF EXISTS administered_outpatient_treatments ;

CREATE TABLE IF NOT EXISTS administered_outpatient_treatments (
  order_id INT NOT NULL,
  timestamp TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (order_id),
  FOREIGN KEY (order_id) REFERENCES outpatient_orders (order_id));

