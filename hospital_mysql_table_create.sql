-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hospital` ;

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
SHOW WARNINGS;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `services` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `services` (
  `svcid` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL COMMENT '',
  `description` VARCHAR(255) NULL COMMENT '',
  PRIMARY KEY (`svcid`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `inpatient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inpatient` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `inpatient` (
  `svcid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`svcid`)  COMMENT '',
  CONSTRAINT `fk_inpatient_svcid1`
    FOREIGN KEY (`svcid`)
    REFERENCES `services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `outpatient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `outpatient` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `outpatient` (
  `svcid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`svcid`)  COMMENT '',
  CONSTRAINT `fk_outpatient_svcid1`
    FOREIGN KEY (`svcid`)
    REFERENCES `services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `nonmedical`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nonmedical` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `nonmedical` (
  `svcid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`svcid`)  COMMENT '',
  CONSTRAINT `fk_nonmedical_svcid1`
    FOREIGN KEY (`svcid`)
    REFERENCES `services` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `workers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `workers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `workers` (
  `wid` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `fname` VARCHAR(45) NOT NULL COMMENT '',
  `lname` VARCHAR(45) NOT NULL COMMENT '',
  `hire_date` DATE NOT NULL COMMENT '',
  PRIMARY KEY (`wid`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `volunteers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `volunteers` (
  `wid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`wid`)  COMMENT '',
  CONSTRAINT `fk_volunteer_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `workers` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `employees`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `employees` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `employees` (
  `wid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`wid`)  COMMENT '',
  CONSTRAINT `fk_employee_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `workers` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `treatment_administrator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `treatment_administrator` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `treatment_administrator` (
  `tadid` INT NOT NULL AUTO_INCREMENT COMMENT '',
  PRIMARY KEY (`tadid`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `nurses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nurses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `nurses` (
  `wid` INT NOT NULL COMMENT '',
  `tadid` INT NULL COMMENT '',
  PRIMARY KEY (`wid`)  COMMENT '',
  CONSTRAINT `fk_nurse_wid`
    FOREIGN KEY (`wid`)
    REFERENCES `employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nurse_tadid`
    FOREIGN KEY (`tadid`)
    REFERENCES `treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `tadid_idx` ON `nurses` (`tadid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `administrators`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `administrators` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `administrators` (
  `wid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`wid`)  COMMENT '',
  CONSTRAINT `fk_admin_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `technicians`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `technicians` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `technicians` (
  `wid` INT NOT NULL COMMENT '',
  `tadid` INT NULL COMMENT '',
  PRIMARY KEY (`wid`)  COMMENT '',
  CONSTRAINT `fk_tech_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tech_tadid1`
    FOREIGN KEY (`tadid`)
    REFERENCES `treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `tadid_idx` ON `technicians` (`tadid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `staff` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `staff` (
  `wid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`wid`)  COMMENT '',
  CONSTRAINT `fk_staff_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `doctors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `doctors` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `doctors` (
  `wid` INT NOT NULL COMMENT '',
  `tadid` INT NULL COMMENT '',
  PRIMARY KEY (`wid`)  COMMENT '',
  CONSTRAINT `fk_doctor_wid1`
    FOREIGN KEY (`wid`)
    REFERENCES `employees` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctor_tadid1`
    FOREIGN KEY (`tadid`)
    REFERENCES `treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `tadid_idx` ON `doctors` (`tadid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `patients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patients` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `patients` (
  `pid` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `fname` VARCHAR(45) NOT NULL COMMENT '',
  `lname` VARCHAR(45) NOT NULL COMMENT '',
  `policynum` VARCHAR(45) NULL COMMENT '',
  `contact` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`pid`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `admissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `admissions` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `admissions` (
  `admission_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `doctors_wid` INT NOT NULL COMMENT '',
  `patient_pid` INT NOT NULL COMMENT '',
  `inpatient_svcid` INT NOT NULL COMMENT '',
  `status` VARCHAR(45) NULL COMMENT '',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`admission_id`, `patient_pid`, `inpatient_svcid`, `doctors_wid`)  COMMENT '',
  CONSTRAINT `fk_primary_doctor1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctor_admits_patient1`
    FOREIGN KEY (`patient_pid`)
    REFERENCES `patients` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inpatient_service1`
    FOREIGN KEY (`inpatient_svcid`)
    REFERENCES `inpatient` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;
CREATE INDEX `fk_doctors_admits_patient1_idx` ON `admissions` (`patient_pid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_admits_inpatient_svc1_idx` ON `admissions` (`inpatient_svcid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_primary_doctor1_idx` ON `admissions` (`doctors_wid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `assigned_doctors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assigned_doctors` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `assigned_doctors` (
  `assigned_doctors_wid` INT NOT NULL COMMENT '',
  `assigned_admission_id` INT NOT NULL COMMENT '',
  PRIMARY KEY (`assigned_doctors_wid`, `assigned_admission_id`)  COMMENT '',
  CONSTRAINT `fk_doctors_has_admits_doctors1`
    FOREIGN KEY (`assigned_doctors_wid`)
    REFERENCES `doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigned_admission_id1`
    FOREIGN KEY (`assigned_admission_id`)
    REFERENCES `admissions` (`admission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_doctors_has_admits_doctors1_idx` ON `assigned_doctors` (`assigned_doctors_wid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_assigned_admission_id1_idx` ON `assigned_doctors` (`assigned_admission_id` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `treatments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `treatments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `treatments` (
  `tid` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(255) NOT NULL COMMENT '',
  PRIMARY KEY (`tid`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medication`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `medication` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `medication` (
  `tid` INT NOT NULL COMMENT '',
  `medid` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`tid`)  COMMENT '',
  CONSTRAINT `fk_medication_tid1`
    FOREIGN KEY (`tid`)
    REFERENCES `treatments` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `procedures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `procedures` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `procedures` (
  `tid` INT NOT NULL COMMENT '',
  `procid` VARCHAR(45) NOT NULL COMMENT '',
  PRIMARY KEY (`tid`)  COMMENT '',
  CONSTRAINT `fk_procedure_tid1`
    FOREIGN KEY (`tid`)
    REFERENCES `treatments` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `orders` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `doctor_wid` INT NOT NULL COMMENT '',
  `admission_id` INT NOT NULL COMMENT '',
  `treatment_administrator_tadid` INT NOT NULL COMMENT '',
  `treatments_tid` INT NOT NULL COMMENT '',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`order_id`, `treatment_administrator_tadid`, `treatments_tid`, `doctor_wid`, `admission_id`)  COMMENT '',
  CONSTRAINT `fk_orders_treatments1`
    FOREIGN KEY (`treatments_tid`)
    REFERENCES `treatments` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_treatment_administrator1`
    FOREIGN KEY (`treatment_administrator_tadid`)
    REFERENCES `treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_admission_id1`
    FOREIGN KEY (`admission_id`)
    REFERENCES `assigned_doctors` (`assigned_doctors_wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_doctor_id1`
    FOREIGN KEY (`doctor_wid`)
    REFERENCES `assigned_doctors` (`assigned_doctors_wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;
CREATE INDEX `fk_orders_treatments1_idx` ON `orders` (`treatments_tid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_orders_treatment_administrator1_idx` ON `orders` (`treatment_administrator_tadid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_orders_admission_id1_idx` ON `orders` (`admission_id` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_orders_doctor_id1_idx` ON `orders` (`doctor_wid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `administered_treatments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `administered_treatments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `administered_treatments` (
  `order_id` INT NOT NULL COMMENT '',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`order_id`)  COMMENT '',
  CONSTRAINT `fk_administered_treatment_order_id1`
    FOREIGN KEY (`order_id`)
    REFERENCES `orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `rooms`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rooms` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `rooms` (
  `roomid` INT NOT NULL AUTO_INCREMENT COMMENT '',
  PRIMARY KEY (`roomid`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `room_assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `room_assignments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `room_assignments` (
  `room_roomid` INT NOT NULL COMMENT '',
  `patient_pid` INT NOT NULL COMMENT '',
  `administrators_wid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`room_roomid`, `patient_pid`, `administrators_wid`)  COMMENT '',
  CONSTRAINT `fk_assigns_room1`
    FOREIGN KEY (`room_roomid`)
    REFERENCES `rooms` (`roomid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigns_patient1`
    FOREIGN KEY (`patient_pid`)
    REFERENCES `admissions` (`doctors_wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigns_administrators1`
    FOREIGN KEY (`administrators_wid`)
    REFERENCES `administrators` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;
CREATE INDEX `fk_assigns_room1_idx` ON `room_assignments` (`room_roomid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_assigns_administrators1_idx` ON `room_assignments` (`administrators_wid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_assigns_patient1_idx` ON `room_assignments` (`patient_pid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `volunteer_schedules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteer_schedules` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `volunteer_schedules` (
  `volunteers_wid` INT NOT NULL COMMENT '',
  `nonmedical_svcid` INT NOT NULL COMMENT '',
  `day` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`volunteers_wid`, `nonmedical_svcid`)  COMMENT '',
  CONSTRAINT `fk_volunteers_has_nonmedical_volunteers1`
    FOREIGN KEY (`volunteers_wid`)
    REFERENCES `volunteers` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_volunteers_has_nonmedical_nonmedical1`
    FOREIGN KEY (`nonmedical_svcid`)
    REFERENCES `nonmedical` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_volunteers_has_nonmedical_nonmedical1_idx` ON `volunteer_schedules` (`nonmedical_svcid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_volunteers_has_nonmedical_volunteers1_idx` ON `volunteer_schedules` (`volunteers_wid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `staff_assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `staff_assignments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `staff_assignments` (
  `staff_wid` INT NOT NULL COMMENT '',
  `nonmedical_svcid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`staff_wid`, `nonmedical_svcid`)  COMMENT '',
  CONSTRAINT `fk_staff_has_nonmedical_staff1`
    FOREIGN KEY (`staff_wid`)
    REFERENCES `staff` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_staff_has_nonmedical_nonmedical1`
    FOREIGN KEY (`nonmedical_svcid`)
    REFERENCES `nonmedical` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_staff_has_nonmedical_nonmedical1_idx` ON `staff_assignments` (`nonmedical_svcid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_staff_has_nonmedical_staff1_idx` ON `staff_assignments` (`staff_wid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `outpatients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `outpatients` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `outpatients` (
  `outpatient_id` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `patients_pid` INT NOT NULL COMMENT '',
  `doctors_wid` INT NOT NULL COMMENT '',
  `outpatient_svcid` INT NOT NULL COMMENT '',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`outpatient_id`, `patients_pid`, `doctors_wid`, `outpatient_svcid`)  COMMENT '',
  CONSTRAINT `fk_outpatient_has_doctors_outpatient1`
    FOREIGN KEY (`outpatient_svcid`)
    REFERENCES `outpatient` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_outpatient_has_doctors_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_outpatients_patients1`
    FOREIGN KEY (`patients_pid`)
    REFERENCES `patients` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_has_doctors_doctors1_idx` ON `outpatients` (`doctors_wid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_has_doctors_outpatient1_idx` ON `outpatients` (`outpatient_svcid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_outpatients_patients1_idx` ON `outpatients` (`patients_pid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnoses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `diagnoses` (
  `diagid` INT NOT NULL AUTO_INCREMENT COMMENT '',
  `name` VARCHAR(45) NULL COMMENT '',
  PRIMARY KEY (`diagid`)  COMMENT '')
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `inpatient_diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inpatient_diagnoses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `inpatient_diagnoses` (
  `diagid` INT NOT NULL COMMENT '',
  `admission_id` INT NOT NULL COMMENT '',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`diagid`, `admission_id`)  COMMENT '',
  CONSTRAINT `fk_diagnosis_diagid1`
    FOREIGN KEY (`diagid`)
    REFERENCES `diagnoses` (`diagid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admission_id1`
    FOREIGN KEY (`admission_id`)
    REFERENCES `admissions` (`admission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;
CREATE INDEX `fk_admission_id1_idx` ON `inpatient_diagnoses` (`admission_id` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `discharges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discharges` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `discharges` (
  `admits_admission_id` INT NOT NULL COMMENT '',
  `administrators_wid` INT NOT NULL COMMENT '',
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '',
  PRIMARY KEY (`admits_admission_id`, `administrators_wid`)  COMMENT '',
  CONSTRAINT `fk_administrators_has_admits_admits1`
    FOREIGN KEY (`admits_admission_id`)
    REFERENCES `admissions` (`admission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_discharges_administrators1`
    FOREIGN KEY (`administrators_wid`)
    REFERENCES `administrators` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_administrators_has_admits_admits1_idx` ON `discharges` (`admits_admission_id` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_discharges_administrators1_idx` ON `discharges` (`administrators_wid` ASC)  COMMENT '';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `outpatient_diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `outpatient_diagnoses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `outpatient_diagnoses` (
  `outpatients_outpatient_id` INT NOT NULL COMMENT '',
  `diagnoses_diagid` INT NOT NULL COMMENT '',
  PRIMARY KEY (`outpatients_outpatient_id`, `diagnoses_diagid`)  COMMENT '',
  CONSTRAINT `fk_outpatient_orders_has_diagnoses_diagnoses1`
    FOREIGN KEY (`diagnoses_diagid`)
    REFERENCES `diagnoses` (`diagid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_outpatient_diagnoses_outpatients1`
    FOREIGN KEY (`outpatients_outpatient_id`)
    REFERENCES `outpatients` (`outpatient_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_orders_has_diagnoses_diagnoses1_idx` ON `outpatient_diagnoses` (`diagnoses_diagid` ASC)  COMMENT '';

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_diagnoses_outpatients1_idx` ON `outpatient_diagnoses` (`outpatients_outpatient_id` ASC)  COMMENT '';

SHOW WARNINGS;
USE `hospital`;

DELIMITER $$

USE `hospital`$$
DROP TRIGGER IF EXISTS `admissions_AFTER_INSERT` $$
SHOW WARNINGS$$
USE `hospital`$$
CREATE DEFINER = CURRENT_USER TRIGGER `hospital`.`admissions_AFTER_INSERT` AFTER INSERT ON `admissions` FOR EACH ROW
BEGIN
INSERT INTO assigned_doctors
SET assigned_admission_id = NEW.admission_id,assigned_doctors_wid = NEW.doctors_wid;
END
$$

SHOW WARNINGS$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `services`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1000, 'Gift Shop', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1010, 'Flourist', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1020, 'Cafeteria', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1030, 'X Ray', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1040, 'Spinal Tap', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1050, 'Minor Surgery', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1060, 'Major Surgery', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1070, 'Blood Transfusion', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1080, 'Evaluation', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1090, 'Checkup', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1100, 'Rehabilitation', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1110, 'Eye Exam', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1120, 'Blood Work', NULL);
INSERT INTO `services` (`svcid`, `name`, `description`) VALUES (1130, 'Counseling', NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `inpatient`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `inpatient` (`svcid`) VALUES (1030);
INSERT INTO `inpatient` (`svcid`) VALUES (1040);
INSERT INTO `inpatient` (`svcid`) VALUES (1050);
INSERT INTO `inpatient` (`svcid`) VALUES (1060);
INSERT INTO `inpatient` (`svcid`) VALUES (1070);

COMMIT;


-- -----------------------------------------------------
-- Data for table `outpatient`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `outpatient` (`svcid`) VALUES (1080);
INSERT INTO `outpatient` (`svcid`) VALUES (1090);
INSERT INTO `outpatient` (`svcid`) VALUES (1100);
INSERT INTO `outpatient` (`svcid`) VALUES (1110);
INSERT INTO `outpatient` (`svcid`) VALUES (1120);
INSERT INTO `outpatient` (`svcid`) VALUES (1130);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nonmedical`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `nonmedical` (`svcid`) VALUES (1000);
INSERT INTO `nonmedical` (`svcid`) VALUES (1010);
INSERT INTO `nonmedical` (`svcid`) VALUES (1020);

COMMIT;


-- -----------------------------------------------------
-- Data for table `workers`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1000, 'Bob', 'Johnson', '2013-03-01');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1001, 'Jane', 'Smith', '2014-01-07');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1002, 'Steve', 'Wilson', '2010-02-03');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1003, 'Cathy', 'Davis', '2008-05-09');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1004, 'Mike', 'Hughes', '2009-06-11');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1005, 'Kate', 'Yates', '2006-04-01');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1006, 'Jeff', 'Payne', '2012-08-14');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1007, 'Carl', 'Morgan', '2007-09-22');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1008, 'Rick', 'Ward', '2003-11-11');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1009, 'Nancy', 'Bates', '2001-08-28');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1010, 'Charles', 'Babbage', '2002-05-05');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1011, 'Alan', 'Turing', '2004-03-19');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1012, 'Larry', 'Wall', '2007-07-09');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1013, 'Edgar', 'Codd', '2002-02-02');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1014, 'Grace', 'Hopper', '2003-06-27');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1015, 'James', 'Gosling', '2001-03-04');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1016, 'Charles', 'Bachman', '2001-06-08');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1017, 'Gordon', 'Bell', '2002-09-09');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1018, 'Peter', 'Chen', '2004-10-31');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1019, 'Ada', 'Lovelace', '2006-03-11');
INSERT INTO `workers` (`wid`, `fname`, `lname`, `hire_date`) VALUES (1020, 'Donald', 'Knuth', '2007-07-04');

COMMIT;


-- -----------------------------------------------------
-- Data for table `volunteers`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `volunteers` (`wid`) VALUES (1003);
INSERT INTO `volunteers` (`wid`) VALUES (1007);
INSERT INTO `volunteers` (`wid`) VALUES (1011);
INSERT INTO `volunteers` (`wid`) VALUES (1009);
INSERT INTO `volunteers` (`wid`) VALUES (1006);

COMMIT;


-- -----------------------------------------------------
-- Data for table `employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `employees` (`wid`) VALUES (1001);
INSERT INTO `employees` (`wid`) VALUES (1002);
INSERT INTO `employees` (`wid`) VALUES (1004);
INSERT INTO `employees` (`wid`) VALUES (1005);
INSERT INTO `employees` (`wid`) VALUES (1008);
INSERT INTO `employees` (`wid`) VALUES (1010);
INSERT INTO `employees` (`wid`) VALUES (1011);
INSERT INTO `employees` (`wid`) VALUES (1012);
INSERT INTO `employees` (`wid`) VALUES (1013);
INSERT INTO `employees` (`wid`) VALUES (1014);
INSERT INTO `employees` (`wid`) VALUES (1015);
INSERT INTO `employees` (`wid`) VALUES (1016);
INSERT INTO `employees` (`wid`) VALUES (1017);
INSERT INTO `employees` (`wid`) VALUES (1018);
INSERT INTO `employees` (`wid`) VALUES (1019);
INSERT INTO `employees` (`wid`) VALUES (1020);

COMMIT;


-- -----------------------------------------------------
-- Data for table `treatment_administrator`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1000);
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1001);
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1002);
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1003);
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1004);
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1005);
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1006);
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1007);
INSERT INTO `treatment_administrator` (`tadid`) VALUES (1008);

COMMIT;


-- -----------------------------------------------------
-- Data for table `nurses`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `nurses` (`wid`, `tadid`) VALUES (1004, 1000);
INSERT INTO `nurses` (`wid`, `tadid`) VALUES (1005, 1001);

COMMIT;


-- -----------------------------------------------------
-- Data for table `administrators`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `administrators` (`wid`) VALUES (1013);
INSERT INTO `administrators` (`wid`) VALUES (1016);
INSERT INTO `administrators` (`wid`) VALUES (1018);
INSERT INTO `administrators` (`wid`) VALUES (1020);

COMMIT;


-- -----------------------------------------------------
-- Data for table `technicians`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `technicians` (`wid`, `tadid`) VALUES (1001, 1003);
INSERT INTO `technicians` (`wid`, `tadid`) VALUES (1002, NULL);
INSERT INTO `technicians` (`wid`, `tadid`) VALUES (1008, 1004);
INSERT INTO `technicians` (`wid`, `tadid`) VALUES (1011, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `staff`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `staff` (`wid`) VALUES (1017);
INSERT INTO `staff` (`wid`) VALUES (1019);

COMMIT;


-- -----------------------------------------------------
-- Data for table `doctors`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `doctors` (`wid`, `tadid`) VALUES (1008, 1005);
INSERT INTO `doctors` (`wid`, `tadid`) VALUES (1010, NULL);
INSERT INTO `doctors` (`wid`, `tadid`) VALUES (1012, 1006);
INSERT INTO `doctors` (`wid`, `tadid`) VALUES (1014, 1007);
INSERT INTO `doctors` (`wid`, `tadid`) VALUES (1015, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `patients`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1000, 'Issac', 'Newton', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1001, 'Leonardo', 'Fibonacci', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1002, 'Albert', 'Einstein', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1003, 'Neils ', 'Bohr', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1004, 'Robert', 'Oppenheimer', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1005, 'Enrico', 'Fermi', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1006, 'Marie', 'Curie', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1007, 'Stephen', 'Hawking', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1008, 'Max', 'Planck', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1009, 'Nikola', 'Tesla', NULL, NULL);
INSERT INTO `patients` (`pid`, `fname`, `lname`, `policynum`, `contact`) VALUES (1010, 'Guglielmo', 'Marconi', NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `admissions`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `admissions` (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`, `status`, `timestamp`) VALUES (1000, 1012, 1010, 1060, NULL, DEFAULT);
INSERT INTO `admissions` (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`, `status`, `timestamp`) VALUES (1001, 1014, 1002, 1030, NULL, DEFAULT);
INSERT INTO `admissions` (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`, `status`, `timestamp`) VALUES (1002, 1008, 1005, 1070, NULL, DEFAULT);
INSERT INTO `admissions` (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`, `status`, `timestamp`) VALUES (1003, 1012, 1000, 1050, NULL, DEFAULT);
INSERT INTO `admissions` (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`, `status`, `timestamp`) VALUES (1004, 1008, 1001, 1030, NULL, DEFAULT);
INSERT INTO `admissions` (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`, `status`, `timestamp`) VALUES (1005, 1010, 1003, 1050, NULL, DEFAULT);
INSERT INTO `admissions` (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`, `status`, `timestamp`) VALUES (1006, 1014, 1004, 1070, NULL, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `treatments`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `treatments` (`tid`, `name`) VALUES (1001, 'Amputation');
INSERT INTO `treatments` (`tid`, `name`) VALUES (1002, 'Leaches');
INSERT INTO `treatments` (`tid`, `name`) VALUES (1003, 'Epidural');
INSERT INTO `treatments` (`tid`, `name`) VALUES (1004, 'Intraveinous Drip');
INSERT INTO `treatments` (`tid`, `name`) VALUES (1005, 'Organ Removal');
INSERT INTO `treatments` (`tid`, `name`) VALUES (1006, 'Electric Shock');

COMMIT;


-- -----------------------------------------------------
-- Data for table `rooms`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `rooms` (`roomid`) VALUES (1112);
INSERT INTO `rooms` (`roomid`) VALUES (1023);
INSERT INTO `rooms` (`roomid`) VALUES (1044);
INSERT INTO `rooms` (`roomid`) VALUES (2040);
INSERT INTO `rooms` (`roomid`) VALUES (2153);
INSERT INTO `rooms` (`roomid`) VALUES (2223);
INSERT INTO `rooms` (`roomid`) VALUES (3122);
INSERT INTO `rooms` (`roomid`) VALUES (3012);
INSERT INTO `rooms` (`roomid`) VALUES (3011);

COMMIT;


-- -----------------------------------------------------
-- Data for table `volunteer_schedules`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `volunteer_schedules` (`volunteers_wid`, `nonmedical_svcid`, `day`) VALUES (1003, 1010, 'Monday');
INSERT INTO `volunteer_schedules` (`volunteers_wid`, `nonmedical_svcid`, `day`) VALUES (1007, 1000, 'Wednesday');
INSERT INTO `volunteer_schedules` (`volunteers_wid`, `nonmedical_svcid`, `day`) VALUES (1009, 1010, 'Tuesday');
INSERT INTO `volunteer_schedules` (`volunteers_wid`, `nonmedical_svcid`, `day`) VALUES (1011, 1020, 'Friday');
INSERT INTO `volunteer_schedules` (`volunteers_wid`, `nonmedical_svcid`, `day`) VALUES (1006, 1000, 'Tuesday');

COMMIT;


-- -----------------------------------------------------
-- Data for table `staff_assignments`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `staff_assignments` (`staff_wid`, `nonmedical_svcid`) VALUES (1017, 1000);
INSERT INTO `staff_assignments` (`staff_wid`, `nonmedical_svcid`) VALUES (1019, 1020);

COMMIT;


-- -----------------------------------------------------
-- Data for table `outpatients`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `outpatients` (`outpatient_id`, `patients_pid`, `doctors_wid`, `outpatient_svcid`, `timestamp`) VALUES (1000, 1000, 1008, 1080, DEFAULT);
INSERT INTO `outpatients` (`outpatient_id`, `patients_pid`, `doctors_wid`, `outpatient_svcid`, `timestamp`) VALUES (1001, 1002, 1010, 1090, DEFAULT);
INSERT INTO `outpatients` (`outpatient_id`, `patients_pid`, `doctors_wid`, `outpatient_svcid`, `timestamp`) VALUES (1002, 1004, 1012, 1100, DEFAULT);
INSERT INTO `outpatients` (`outpatient_id`, `patients_pid`, `doctors_wid`, `outpatient_svcid`, `timestamp`) VALUES (1003, 1006, 1014, 1110, DEFAULT);
INSERT INTO `outpatients` (`outpatient_id`, `patients_pid`, `doctors_wid`, `outpatient_svcid`, `timestamp`) VALUES (1004, 1008, 1015, 1120, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `diagnoses`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1000, 'Common Cold');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1010, 'Gangrene');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1020, 'Chicken Pox');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1030, 'Brain Damage');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1040, 'Jaundice');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1050, 'Food Poisoning');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1060, 'Hypochondria');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1070, 'Scoliosis');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1080, 'Carpal Tunnel Syndrome');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1090, 'Blindness');
INSERT INTO `diagnoses` (`diagid`, `name`) VALUES (1100, 'Hearing Loss');

COMMIT;


-- -----------------------------------------------------
-- Data for table `inpatient_diagnoses`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `inpatient_diagnoses` (`diagid`, `admission_id`, `timestamp`) VALUES (1030, 1001, DEFAULT);
INSERT INTO `inpatient_diagnoses` (`diagid`, `admission_id`, `timestamp`) VALUES (1040, 1002, DEFAULT);
INSERT INTO `inpatient_diagnoses` (`diagid`, `admission_id`, `timestamp`) VALUES (1010, 1003, DEFAULT);
INSERT INTO `inpatient_diagnoses` (`diagid`, `admission_id`, `timestamp`) VALUES (1000, 1004, DEFAULT);
INSERT INTO `inpatient_diagnoses` (`diagid`, `admission_id`, `timestamp`) VALUES (1040, 1005, DEFAULT);
INSERT INTO `inpatient_diagnoses` (`diagid`, `admission_id`, `timestamp`) VALUES (1030, 1006, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `outpatient_diagnoses`
-- -----------------------------------------------------
START TRANSACTION;
USE `hospital`;
INSERT INTO `outpatient_diagnoses` (`outpatients_outpatient_id`, `diagnoses_diagid`) VALUES (1004, 1020);
INSERT INTO `outpatient_diagnoses` (`outpatients_outpatient_id`, `diagnoses_diagid`) VALUES (1000, 1050);
INSERT INTO `outpatient_diagnoses` (`outpatients_outpatient_id`, `diagnoses_diagid`) VALUES (1002, 1010);
INSERT INTO `outpatient_diagnoses` (`outpatients_outpatient_id`, `diagnoses_diagid`) VALUES (1001, 1080);

COMMIT;

