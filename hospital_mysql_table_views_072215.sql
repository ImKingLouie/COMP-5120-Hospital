
USE hospital;

-- -----------------------------------------------------
-- View all_treatment_administrators
-- -----------------------------------------------------
DROP VIEW IF EXISTS all_treatment_administrators ;


CREATE VIEW all_treatment_administrators AS 
SELECT ta.treatment_admin_id AS tadid, d.doctor_id AS wid FROM (treatment_administrator ta 
JOIN doctors d ON ((ta.treatment_admin_id = d.treatment_admin_id))) 
UNION SELECT ta.treatment_admin_id AS tadid, n.nurse_id AS wid FROM (treatment_administrator ta 
JOIN nurses n ON ((ta.treatment_admin_id = n.treatment_admin_id))) 
UNION SELECT ta.treatment_admin_id AS tadid, t.technician_id AS wid FROM (treatment_administrator ta 
JOIN technicians t ON ((ta.treatment_admin_id = t.treatment_admin_id)));

-- -----------------------------------------------------
-- View treatment_administrator_workers
-- -----------------------------------------------------
DROP VIEW IF EXISTS treatment_administrator_workers ;

CREATE OR REPLACE VIEW treatment_administrator_workers AS
SELECT admins.tadid AS tadid, workers.fname AS fname FROM (workers
JOIN all_treatment_administrators admins ON ((workers.worker_id = admins.wid)));

-- -----------------------------------------------------
-- View current_admissions
-- -----------------------------------------------------
DROP VIEW IF EXISTS current_admissions ;

CREATE OR REPLACE VIEW current_admissions AS
SELECT a.admission_id AS admission_id, a.patient_id AS patient_id
FROM (admissions a LEFT JOIN discharges d ON ((a.admission_id = d.admission_id)))
WHERE isnull(d.admission_id);

-- -----------------------------------------------------
-- View eligible_treatment_administrators
-- -----------------------------------------------------
DROP VIEW IF EXISTS eligible_treatment_administrators ;

CREATE  OR REPLACE VIEW eligible_treatment_administrators AS
SELECT nurse_id AS worker_id FROM nurses WHERE treatment_admin_id IS NULL 
UNION select doctor_id AS worker_id FROM doctors WHERE treatment_admin_id IS NULL 
UNION select technician_id AS worker_id FROM technicians WHERE treatment_admin_id IS NULL;


-- -----------------------------------------------------
-- Triggers for doctor patient assignments
-- -----------------------------------------------------

DROP TRIGGER IF EXISTS admissions_assignment;
DROP TRIGGER IF EXISTS outpatient_assignment;

CREATE TRIGGER admissions_assignment AFTER INSERT ON admissions FOR EACH ROW
INSERT INTO assigned_doctors VALUES(NULL, NEW.doctor_id, NEW.patient_id);

CREATE TRIGGER outpatient_assignment AFTER INSERT ON outpatient_orders FOR EACH ROW
INSERT INTO assigned_doctors VALUES(NULL, NEW.doctor_id, NEW.patient_id);

