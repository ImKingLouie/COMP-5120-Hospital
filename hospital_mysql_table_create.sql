SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema hospital
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hospital` ;
CREATE SCHEMA IF NOT EXISTS `hospital` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
SHOW WARNINGS;
USE `hospital` ;

-- -----------------------------------------------------
-- Table `services`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `services` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `services` (
  `svcid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(255) NULL,
  PRIMARY KEY (`svcid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `inpatient`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inpatient` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `inpatient` (
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
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
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
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
  `svcid` INT NOT NULL,
  PRIMARY KEY (`svcid`),
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
  `wid` INT NOT NULL AUTO_INCREMENT,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `hire_date` DATETIME NOT NULL,
  PRIMARY KEY (`wid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `volunteers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteers` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `volunteers` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
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
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
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
  `tadid` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tadid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `nurses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `nurses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `nurses` (
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
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
CREATE INDEX `tadid_idx` ON `nurses` (`tadid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `administrators`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `administrators` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `administrators` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
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
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
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
CREATE INDEX `tadid_idx` ON `technicians` (`tadid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `staff` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `staff` (
  `wid` INT NOT NULL,
  PRIMARY KEY (`wid`),
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
  `wid` INT NOT NULL,
  `tadid` INT NULL,
  PRIMARY KEY (`wid`),
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
CREATE INDEX `tadid_idx` ON `doctors` (`tadid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `patients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `patients` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `patients` (
  `pid` INT NOT NULL AUTO_INCREMENT,
  `policynum` VARCHAR(45) NULL,
  `contact` VARCHAR(45) NULL,
  PRIMARY KEY (`pid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `admits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `admits` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `admits` (
  `admission_id` INT NOT NULL AUTO_INCREMENT,
  `doctors_wid` INT NOT NULL,
  `patient_pid` INT NOT NULL,
  `inpatient_svcid` INT NOT NULL,
  `status` VARCHAR(45) NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admission_id`, `doctors_wid`, `patient_pid`, `inpatient_svcid`),
  CONSTRAINT `fk_doctor_assigns_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctors_has_patient_patient1`
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
CREATE INDEX `fk_doctors_has_patient_patient1_idx` ON `admits` (`patient_pid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_doctors_has_patient_doctors1_idx` ON `admits` (`doctors_wid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_admits_inpatient1_idx` ON `admits` (`inpatient_svcid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `assigned_doctors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `assigned_doctors` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `assigned_doctors` (
  `doctors_wid` INT NOT NULL,
  `admits_admission_id` INT NOT NULL,
  `admits_doctors_wid` INT NOT NULL,
  PRIMARY KEY (`doctors_wid`, `admits_admission_id`, `admits_doctors_wid`),
  CONSTRAINT `fk_doctors_has_admits_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigned_doctors_admits1`
    FOREIGN KEY (`admits_admission_id` , `admits_doctors_wid`)
    REFERENCES `admits` (`admission_id` , `doctors_wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_doctors_has_admits_doctors1_idx` ON `assigned_doctors` (`doctors_wid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_assigned_doctors_admits1_idx` ON `assigned_doctors` (`admits_admission_id` ASC, `admits_doctors_wid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `treatments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `treatments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `treatments` (
  `tid` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`tid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `medication`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `medication` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `medication` (
  `tid` INT NOT NULL,
  `medid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tid`),
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
  `tid` INT NOT NULL,
  `procid` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`tid`),
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
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `doctors_wid` INT NOT NULL,
  `treatment_tid` INT NOT NULL,
  `tadid` INT NOT NULL,
  `patients_pid` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`, `doctors_wid`, `treatment_tid`, `tadid`, `patients_pid`),
  CONSTRAINT `fk_doctors_has_treatment_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctors_has_treatment_treatment1`
    FOREIGN KEY (`treatment_tid`)
    REFERENCES `treatments` (`tid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_treatment_administrator1`
    FOREIGN KEY (`tadid`)
    REFERENCES `treatment_administrator` (`tadid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_patients1`
    FOREIGN KEY (`patients_pid`)
    REFERENCES `patients` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;
CREATE INDEX `fk_doctors_has_treatment_treatment1_idx` ON `orders` (`treatment_tid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_doctors_has_treatment_doctors1_idx` ON `orders` (`doctors_wid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_orders_treatment_administrator1_idx` ON `orders` (`tadid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_orders_patients1_idx` ON `orders` (`patients_pid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `administered_treatments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `administered_treatments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `administered_treatments` (
  `order_id` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`),
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
  `roomid` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`roomid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `room_assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `room_assignments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `room_assignments` (
  `room_roomid` INT NOT NULL,
  `patient_pid` INT NOT NULL,
  `administrators_wid` INT NOT NULL,
  PRIMARY KEY (`room_roomid`, `patient_pid`, `administrators_wid`),
  CONSTRAINT `fk_assigns_room1`
    FOREIGN KEY (`room_roomid`)
    REFERENCES `rooms` (`roomid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assigns_patient1`
    FOREIGN KEY (`patient_pid`)
    REFERENCES `admits` (`doctors_wid`)
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
CREATE INDEX `fk_assigns_room1_idx` ON `room_assignments` (`room_roomid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_assigns_administrators1_idx` ON `room_assignments` (`administrators_wid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_assigns_patient1_idx` ON `room_assignments` (`patient_pid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `volunteer_schedules`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `volunteer_schedules` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `volunteer_schedules` (
  `volunteers_wid` INT NOT NULL,
  `nonmedical_svcid` INT NOT NULL,
  `day` VARCHAR(45) NULL,
  PRIMARY KEY (`volunteers_wid`, `nonmedical_svcid`),
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
CREATE INDEX `fk_volunteers_has_nonmedical_nonmedical1_idx` ON `volunteer_schedules` (`nonmedical_svcid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_volunteers_has_nonmedical_volunteers1_idx` ON `volunteer_schedules` (`volunteers_wid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `staff_assignments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `staff_assignments` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `staff_assignments` (
  `staff_wid` INT NOT NULL,
  `nonmedical_svcid` INT NOT NULL,
  PRIMARY KEY (`staff_wid`, `nonmedical_svcid`),
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
CREATE INDEX `fk_staff_has_nonmedical_nonmedical1_idx` ON `staff_assignments` (`nonmedical_svcid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_staff_has_nonmedical_staff1_idx` ON `staff_assignments` (`staff_wid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `outpatients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `outpatients` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `outpatients` (
  `outpatient_svcid` INT NOT NULL,
  `doctors_wid` INT NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`outpatient_svcid`, `doctors_wid`),
  CONSTRAINT `fk_outpatient_has_doctors_outpatient1`
    FOREIGN KEY (`outpatient_svcid`)
    REFERENCES `outpatient` (`svcid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_outpatient_has_doctors_doctors1`
    FOREIGN KEY (`doctors_wid`)
    REFERENCES `doctors` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_has_doctors_doctors1_idx` ON `outpatients` (`doctors_wid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_has_doctors_outpatient1_idx` ON `outpatients` (`outpatient_svcid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `diagnoses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `diagnoses` (
  `diagid` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`diagid`))
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `inpatient_diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `inpatient_diagnoses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `inpatient_diagnoses` (
  `diagid` INT NOT NULL,
  `admission_id` INT NOT NULL,
  `timestamp` DATETIME NOT NULL,
  PRIMARY KEY (`diagid`, `admission_id`),
  CONSTRAINT `fk_diagnosis_diagid1`
    FOREIGN KEY (`diagid`)
    REFERENCES `diagnoses` (`diagid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_admission_id1`
    FOREIGN KEY (`admission_id`)
    REFERENCES `admits` (`admission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;
CREATE INDEX `fk_admission_id1_idx` ON `inpatient_diagnoses` (`admission_id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table ``
-- -----------------------------------------------------
DROP TABLE IF EXISTS `` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `` (
)
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `discharges`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `discharges` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `discharges` (
  `admits_admission_id` INT NOT NULL,
  `administrators_wid` INT NOT NULL,
  `timestamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`admits_admission_id`, `administrators_wid`),
  CONSTRAINT `fk_administrators_has_admits_admits1`
    FOREIGN KEY (`admits_admission_id`)
    REFERENCES `admits` (`admission_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_discharges_administrators1`
    FOREIGN KEY (`administrators_wid`)
    REFERENCES `administrators` (`wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_administrators_has_admits_admits1_idx` ON `discharges` (`admits_admission_id` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_discharges_administrators1_idx` ON `discharges` (`administrators_wid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `outpatient_orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `outpatient_orders` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `outpatient_orders` (
  `outpatient_order_id` INT NOT NULL AUTO_INCREMENT,
  `outpatients_outpatient_svcid` INT NOT NULL,
  `outpatients_doctors_wid` INT NOT NULL,
  `patients_pid` INT NOT NULL,
  PRIMARY KEY (`outpatient_order_id`, `patients_pid`, `outpatients_outpatient_svcid`, `outpatients_doctors_wid`),
  CONSTRAINT `fk_outpatients_has_doctors_outpatients1`
    FOREIGN KEY (`outpatients_outpatient_svcid` , `outpatients_doctors_wid`)
    REFERENCES `outpatients` (`outpatient_svcid` , `doctors_wid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_outpatient_orders_patients1`
    FOREIGN KEY (`patients_pid`)
    REFERENCES `patients` (`pid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1000;

SHOW WARNINGS;
CREATE INDEX `fk_outpatients_has_doctors_outpatients1_idx` ON `outpatient_orders` (`outpatients_outpatient_svcid` ASC, `outpatients_doctors_wid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_orders_patients1_idx` ON `outpatient_orders` (`patients_pid` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `outpatient_diagnoses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `outpatient_diagnoses` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `outpatient_diagnoses` (
  `diagnoses_diagid` INT NOT NULL,
  `outpatient_orders_outpatient_order_id` INT NOT NULL,
  PRIMARY KEY (`diagnoses_diagid`, `outpatient_orders_outpatient_order_id`),
  CONSTRAINT `fk_outpatient_orders_has_diagnoses_diagnoses1`
    FOREIGN KEY (`diagnoses_diagid`)
    REFERENCES `diagnoses` (`diagid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_outpatient_diagnoses_outpatient_orders1`
    FOREIGN KEY (`outpatient_orders_outpatient_order_id`)
    REFERENCES `outpatient_orders` (`outpatient_order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_orders_has_diagnoses_diagnoses1_idx` ON `outpatient_diagnoses` (`diagnoses_diagid` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_outpatient_diagnoses_outpatient_orders1_idx` ON `outpatient_diagnoses` (`outpatient_orders_outpatient_order_id` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `timestamps`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `timestamps` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `timestamps` (
  `create_time`  NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time`  NULL);

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
