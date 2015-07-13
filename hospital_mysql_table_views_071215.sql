
-- -----------------------------------------------------
-- View `all_treatment_administrators`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `all_treatment_administrators` ;
SHOW WARNINGS;
USE `hospital`;
CREATE 
     OR REPLACE ALGORITHM = UNDEFINED 
    DEFINER = `root`@`%` 
    SQL SECURITY DEFINER
VIEW `all_treatment_administrators` AS
    select 
        `ta`.`treatment_admin_id` AS `tadid`, `d`.`doctor_id` AS `wid`
    from
        (`treatment_administrator` `ta`
        join `doctors` `d` ON ((`ta`.`treatment_admin_id` = `d`.`treatment_admin_id`))) 
    union select 
        `ta`.`treatment_admin_id` AS `tadid`, `n`.`nurse_id` AS `wid`
    from
        (`treatment_administrator` `ta`
        join `nurses` `n` ON ((`ta`.`treatment_admin_id` = `n`.`treatment_admin_id`))) 
    union select 
        `ta`.`treatment_admin_id` AS `tadid`, `t`.`technician_id` AS `wid`
    from
        (`treatment_administrator` `ta`
        join `technicians` `t` ON ((`ta`.`treatment_admin_id` = `t`.`treatment_admin_id`)));
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `treatment_administrator_workers`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `treatment_administrator_workers` ;
SHOW WARNINGS;
USE `hospital`;
CREATE  OR REPLACE VIEW `treatment_administrator_workers` AS
select 
        `admins`.`tadid` AS `tadid`, `workers`.`fname` AS `fname`
    from
        (`workers`
        join `all_treatment_administrators` `admins` ON ((`workers`.`worker_id` = `admins`.`wid`)))
;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `patient_admission_ids`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `patient_admission_ids` ;
SHOW WARNINGS;
USE `hospital`;
CREATE  OR REPLACE VIEW `patient_admission_ids` AS
select admissions.admission_id, fname from assigned_doctors JOIN admissions ON admissions.admission_id = assigned_doctors.admission_id JOIN patients ON patients.patient_id = admissions.patient_id;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `current_admissions`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `current_admissions` ;
SHOW WARNINGS;
USE `hospital`;
CREATE  OR REPLACE VIEW `current_admissions` AS
    select 
        `a`.`admission_id` AS `admission_id`,
        `a`.`patient_id` AS `patient_id`
    from
        (`admissions` `a`
        left join `discharges` `d` ON ((`a`.`admission_id` = `d`.`admission_id`)))
    where
        isnull(`d`.`admission_id`)
;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `assignment_doctor_patients`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `assignment_doctor_patients` ;
SHOW WARNINGS;
USE `hospital`;
CREATE  OR REPLACE VIEW `assignment_doctor_patients` AS
    select 
        `assigned_doctors`.`assignment_id` AS `assignment_id`,
        `workers`.`fname` AS `doctor_name`,
        `patients`.`fname` AS `patient_name`
    from
        (((`assigned_doctors`
        join `workers` ON ((`workers`.`worker_id` = `assigned_doctors`.`doctor_id`)))
        join `current_admissions` ON ((`current_admissions`.`admission_id` = `assigned_doctors`.`admission_id`)))
        join `patients` ON ((`patients`.`patient_id` = `current_admissions`.`patient_id`)));
SHOW WARNINGS;

DELIMITER $$

USE `hospital`$$
DROP TRIGGER IF EXISTS `admissions_assignment` $$
SHOW WARNINGS$$
USE `hospital`$$
CREATE TRIGGER `admissions_assignment` AFTER INSERT ON `admissions` FOR EACH ROW
INSERT INTO assigned_doctors VALUES(NEW.doctor_id, NEW.admission_id, NULL);
$$

SHOW WARNINGS$$

DELIMITER ;