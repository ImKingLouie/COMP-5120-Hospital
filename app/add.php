<?php

$mysqli = new mysqli("172.16.60.129", "root", "linux", "hospital");
//$mysqli = new mysqli("acadmysql.duc.auburn.edu", "comp5120g2", "pw4g2!", "hospital");

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: " . $mysqli->connect_errno . " -> " . $mysqli->connect_error;
}

// Dynamic basic query ...

function basic_table_dl($mysqli, $table_name, $key, $value) {

  $select = sprintf("<select name='%s'>", $table_name);

  $q = sprintf("SELECT * FROM %s;", $table_name);

  //echo $q;

  $res = $mysqli->query($q);

  while ($row = $res->fetch_array()) {

    $select .= sprintf("<option value='%s'>%s</option>", $row[$key], $row[$value]);

  }

  $select .= "</select>";

  return $select;

}

// Dynamic Join Query ...

function join_table_dl($mysqli, $table_name1, $table_name2, $id1, $id2, $key, $value, $name) {

  $select = sprintf("<select name='%s'>", $name);

  $q = sprintf("SELECT * FROM %s JOIN %s ON %s.%s = %s.%s;", $table_name1, $table_name2, $table_name1, $id1, $table_name2, $id2);

  //echo $q;

  $res = $mysqli->query($q);

  while ($row = $res->fetch_array()) {

    $select .= sprintf("<option value='%s'>%s</option>", $row[$key], $row[$value]);

  }

  $select .= "</select>";

  return $select;

}

// Dynamic multiple key query ...

function multiple_key_table_dl($mysqli, $table_name, $key, $value1, $value2) {

  $select = sprintf("<select name='%s'>", $table_name);

  $q = sprintf("SELECT * FROM %s;", $table_name);

  //echo $q;

  $res = $mysqli->query($q);

  while ($row = $res->fetch_array()) {

    $select .= sprintf("<option value='%s'>%s -> %s</option>", $row[$key], $row[$value1], $row[$value2]);

  }

  $select .= "</select>";

  return $select;

}

// Dynamic exclusion query ...

function exclusion_table_dl($mysqli, $table_name1, $table_name2, $key1, $key2, $value) {

  $select = sprintf("<select name='%s'>", $table_name1);

  $q = sprintf("SELECT * FROM %s LEFT JOIN %s ON %s.%s = %s.%s WHERE %s.%s IS NULL;", $table_name1, $table_name2, $table_name1, $key1, $table_name2, $key2, $table_name2, $key2);

  //echo $q;

  $res = $mysqli->query($q);

  while ($row = $res->fetch_array()) {

    $select .= sprintf("<option value='%s'>%s</option>", $row[0], $row[$value]);

  }

  $select .= "</select>";

  return $select;

}


// Form Processing...

if($_POST['insert']) {

  $table_name = array_pop($_POST);
  $remove_button = array_pop($_POST);

  $cols_sql = sprintf("SELECT column_name FROM information_schema.columns WHERE table_schema='hospital' AND table_name = '%s' LIMIT %s;", $table_name, count($_POST));

  $cols = $mysqli->query($cols_sql);

  while($key = $cols->fetch_array()) {

    $keys[] = $key[0];

  }

  foreach($_POST as $key => $value) {

    if (is_numeric($value) || $value == 'NULL') {
      $values[] = mysqli_real_escape_string($mysqli,$value);
    } else {
      $values[] = "'".mysqli_real_escape_string($mysqli,$value)."'";
    }

  }

  $q = sprintf("INSERT INTO %s (%s) VALUES(%s);", $table_name, implode(", ", $keys), implode(", ", $values));

  $res = $mysqli->query($q);

  if($res) {

    print 'OK. Rows affected: ' .$mysqli->insert_id .'<br />';

    $q = preg_replace('/NULL/', $mysqli->insert_id, $q, 1);

    printf("<p>SQL: %s</p>", $q);

    $file = "insert_statements.sql";

    file_put_contents($file, $q . "\n", FILE_APPEND | LOCK_EX);

  } else {
    echo $q;
    die('<p>Error : ('. $mysqli->errno .') '. $mysqli->error . '</p>');
  }

}

if($_POST['update']) {

  $table_name = array_pop($_POST);
  $remove_button = array_pop($_POST);
  $primary_key_val = array_pop($_POST);

  $primary_sql = sprintf("SELECT column_name FROM information_schema.columns WHERE table_schema='hospital' AND table_name = '%s' AND COLUMN_KEY = 'PRI' LIMIT 1;", $table_name);

  //echo $primary_sql;

  $prim = $mysqli->query($primary_sql);

  while($key = $prim->fetch_array()) {

    $prim_keys[] = $key[0];

  }

  $cols_sql = sprintf("SELECT column_name FROM information_schema.columns WHERE table_schema='hospital' AND table_name = '%s' AND COLUMN_KEY != 'PRI' LIMIT 1;", $table_name);

  //echo $cols_sql;

  $cols = $mysqli->query($cols_sql);

  while($key = $cols->fetch_array()) {

    $keys[] = $key[0];

  }

  foreach($_POST as $key => $value) {

    if (is_numeric($value) || $value == 'NULL') {
      $values[] = mysqli_real_escape_string($mysqli,$value);
    } else {
      $values[] = "'".mysqli_real_escape_string($mysqli,$value)."'";
    }

  }

  foreach($values as $key => $val) {

    if (is_numeric($primary_key_val) || $primary_key_val == 'NULL') {
      $primary_key_val = mysqli_real_escape_string($mysqli,$primary_key_val);
    } else {
      $primary_key_val = "'".mysqli_real_escape_string($mysqli,$primary_key_val)."'";
    }

    if (is_numeric($val) || $val == 'NULL') {
      $val = mysqli_real_escape_string($mysqli,$value);
    } else {
      $val = "'".mysqli_real_escape_string($mysqli,$value)."'";
    }

    $q = sprintf("UPDATE %s SET %s = %s WHERE %s = %s;", $table_name, $keys[0], $val, $prim_keys[0], $primary_key_val);

    echo $q;

    printf("<p>SQL: %s</p>", $q);

    $res = $mysqli->query($q);

    if($res) {

      print 'OK. Rows affected: ' .$mysqli->insert_id .'<br />';

      $file = "insert_statements.sql";

      file_put_contents($file, $q . "\n", FILE_APPEND | LOCK_EX);

    } else {
      die('<p>Error : ('. $mysqli->errno .') '. $mysqli->error . '</p>');
    }

  }

}

// Form Rendering

printf("<div id='Employee Inserts'>");

printf("<h3>Add Worker</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='worker_id' value='NULL'>");
printf("<br>First Name: ");
printf("<input type='text' name='fname'>");
printf("<br>Last Name: ");
printf("<input type='text' name='lname'>");
printf("<br>Date of Hire: ");
printf("<input type='text' name='hire_date'>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='workers'>");
printf("</form>");

printf("<h3>Add Service</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='service_id' value='NULL'>");
printf("<br>Service Name: ");
printf("<input type='text' name='name'>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='services'>");
printf("</form>");

printf("<h3>Add Outpatient Service</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "services", "outpatient", "service_id", "service_id", 1));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='outpatient'>");
printf("</form>");

printf("<h3>Add Inpatient Service</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "services", "inpatient", "service_id", "service_id", 1));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='inpatient'>");
printf("</form>");

printf("<h3>Add Nonmedical Service</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "services", "nonmedical", "service_id", "service_id", 1));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='inpatient'>");
printf("</form>");

printf("<h3>Add Employees</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "workers", "employees", "worker_id", "employee_id", 1));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='employees'>");
printf("</form>");

printf("<h3>Add Volunteers</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "workers", "volunteers", "worker_id", "volunteer_id", 1));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='volunteers'>");
printf("</form>");

printf("<h3>Add Doctor</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "employees", "doctors", "employee_id", "doctor_id", 0));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='doctors'>");
printf("</form>");

printf("<h3>Add Admitting Doctor</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "doctors", "admitting_doctors", "doctor_id", "doctor_id", 0));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='admitting_doctors'>");
printf("</form>");

printf("<h3>Add Technician</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "employees", "technicians", "employee_id", "technician_id", 0));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='technicians'>");
printf("</form>");

printf("<h3>Add Nurse</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "employees", "nurses", "employee_id", "nurse_id", 0));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='nurses'>");
printf("</form>");

printf("<h3>Add Staff</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "employees", "staff", "employee_id", "staff_id", 0));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='staff'>");
printf("</form>");

printf("<h3>Add Administrator</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf(exclusion_table_dl($mysqli, "employees", "administrators", "employee_id", "administrator_id", 0));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='administrators'>");
printf("</form>");

printf("<h3>Assign Volunteer Schedule</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Volunteer: ");
printf(join_table_dl($mysqli, "volunteers", "workers", "volunteer_id", "worker_id", 0, 2, "volunteers"));
printf("<br>Service: ");
printf(join_table_dl($mysqli, "nonmedical", "services", "service_id", "service_id", 0, 2, "services"));
printf("<br>Day: ");
printf("<select name='type'><option value='sunday'>Sunday</option><option value='monday'>Monday</option><option value='tuesday'>Tuesday</option><option value='wednesday'>Wednesday</option><option value='thursday'>Thursday</option><option value='friday'>Friday</option><option value='saturday'>Saturday</option></select>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='volunteer_schedules'>");
printf("</form>");

printf("<h3>Assign Staff</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Worker: ");
printf(join_table_dl($mysqli, "staff", "workers", "staff_id", "worker_id", 0, 2, "staff"));
printf("<br>Service: ");
printf(join_table_dl($mysqli, "nonmedical", "services", "service_id", "service_id", 0, 2, "services"));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='staff_assignments'>");
printf("</form>");

printf("</div>");

printf("<div id='Diagnosis & Treatment Inserts'>");

printf("<h3>Add Patient</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='patient_id' value='NULL'>");
printf("<br>First Name: ");
printf("<input type='text' name='fname'>");
printf("<br>Last Name: ");
printf("<input type='text' name='lname'>");
printf("<br>Policy Number: ");
printf("<input type='text' name='policynum'>");
printf("<br>Emergency Contact: ");
printf("<input type='text' name='contact'>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='patients'>");
printf("</form>");

printf("<h3>Add Diagnosis</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='diagnosis_id' value='NULL'>");
printf("<br>Diagnosis Name: ");
printf("<input type='text' name='name'>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='diagnoses'>");
printf("</form>");

printf("<h3>Add Treatment</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='treatment_id' value='NULL'>");
printf("<br>Treatment Name: ");
printf("<input type='text' name='name'>");
printf("<br>Type: ");
printf("<select name='type'><option value='procedure'>Procedure</option><option value='medication'>Medication</option></select>");
printf("<br>Service Type: ");
printf("<select name='type'><option value='inpatient'>Inpatient</option><option value='outpatient'>Outpatient</option><option value='independent'>Independent</option></select>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='treatments'>");
printf("</form>");

printf("<h3>Order Outpatient Service</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='outpatient_id' value='NULL'>");
printf("<br>Doctor: ");
printf(join_table_dl($mysqli, "doctors", "workers", "doctor_id", "worker_id", 0, 3, "doctors"));
printf("<br>Patient: ");
printf(basic_table_dl($mysqli, "patients", "patient_id", "fname"));
printf("<br>Inpatient Service: ");
printf(join_table_dl($mysqli, "outpatient", "services", "service_id", "service_id", 0, 2, "service"));
printf("<br>Diagnosis: ");
printf(basic_table_dl($mysqli, "diagnoses", "diagnosis_id", "name"));
printf("<br>Start Date: ");
printf("<input type='text' name='start_date'>");
printf("<br>End Date: ");
printf("<input type='text' name='end_date'>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='outpatient_orders'>");
printf("</form>");

printf("<h3>Admit Patient</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='admission_id' value='NULL'>");
printf("<br>Doctor: ");
printf(join_table_dl($mysqli, "admitting_doctors", "workers", "doctor_id", "worker_id", 0, 2, "doctors"));
printf("<br>Patient: ");
printf(basic_table_dl($mysqli, "patients", "patient_id", "fname"));
printf("<br>Inpatient Service: ");
printf(join_table_dl($mysqli, "inpatient", "services", "service_id", "service_id", 0, 2, "service"));
printf("<br>Diagnosis: ");
printf(basic_table_dl($mysqli, "diagnoses", "diagnosis_id", "name"));
printf("<br>Admission Date: ");
printf("<input type='text' name='timestamp'>");
printf("<br>Status: ");
printf("<select name='status'><option value='active'>Active</option><option value='inactive'>Inactive</option></select>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='admissions'>");
printf("</form>");

printf("<h3>Add Room</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Room ID: ");
printf("<input type='text' name='room_id'>");
printf("<input type='hidden' name='admission_id' value='NULL'>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='rooms'>");
printf("</form>");

printf("<h3>Assign Room</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Admission ID: ");
printf(exclusion_table_dl($mysqli, "admissions", "discharges", "admission_id", "admission_id", 0));
printf("<br>Room ID: ");
printf(basic_table_dl($mysqli, "rooms", "room_id", "room_id"));
printf("<br><input type='submit' name='update'>");
printf("<input type='hidden' name='table_name' value='rooms'>");
printf("</form>");

printf("<h3>Assign Doctor</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Doctor: ");
printf(join_table_dl($mysqli, "doctors", "workers", "doctor_id", "worker_id", 0, 3, "doctors"));
printf("<br>Admission: ");
printf(join_table_dl($mysqli, "admissions", "patients", "patient_id", "patient_id", 0, 7, "admissions"));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='assigned_doctors'>");
printf("</form>");

printf("<h3>Add Treatment Order</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='order_id' value='NULL'>");
printf("<br>Doctor: ");
printf(join_table_dl($mysqli, "doctors", "workers", "doctor_id", "worker_id", 0, 3, "doctors"));
printf("<br>Patient:");
printf(join_table_dl($mysqli, "admissions", "patients", "patient_id", "patient_id", 0, 3, "patients"));
printf("<br>Treatment: ");
printf(basic_table_dl($mysqli, "treatments", 0, 1));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='treatment_orders'>");
printf("</form>");

printf("<h3>Add Treatment Administrator</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Worker: ");
printf(basic_table_dl($mysqli, "eligible_treatment_administrators", 0, 0));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='treatment_administrator'>");
printf("</form>");

printf("<h3>Administer Treatment</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Order ID: ");
printf(basic_table_dl($mysqli, "treatment_orders", "order_id", "order_id"));
printf("<br>Treatment Administrator: ");
printf(basic_table_dl($mysqli, "treatment_administrator_workers", 0, 1));
printf("<input type='hidden' name='timestamp' value='NULL'>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='administered_treatments'>");
printf("</form>");
printf("</div>");

printf("<h3>Discharge Patient</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Admitted Patient: ");
printf(exclusion_table_dl($mysqli, "admissions", "discharges", "admission_id", "admission_id", 0));
printf("<br>Administrator: ");
printf(join_table_dl($mysqli, "administrators", "workers", "administrator_id", "worker_id", 0, 2, "admin"));
printf("<input type='hidden' name='timestamp' value='NULL'>");
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='discharges'>");
printf("</form>");



?>
