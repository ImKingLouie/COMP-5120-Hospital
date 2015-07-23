<?php

require_once("header.php");

$mysqli = new mysqli("acadmysql.duc.auburn.edu", "comp5120g2", "pw4g2!", "hospital");
//$mysqli = new mysqli("172.16.60.129", "root", "linux", "hospital");

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: " . $mysqli->connect_errno . " -> " . $mysqli->connect_error;
}

?>

<h3>Query Requirements</h3>

<h4>Room Utilization</h4>

<ol>
  <li>Occupied Rooms</li>
  <li>Unoccupied Rooms</li>
  <li>All Rooms</li>
</ol>

<h4>Patient Information</h4>

<ol>
  <li>All Patients</li>
  <li>Currently Admitted</li>
  <li>Inpatient Services Date Range</li>
  <li>Patient Discharge Date Range</li>
  <li>Current Outpatients</li>
  <li>Outpatients Date Range</li>
  <li>Admissions by Patient</li>
  <li>Treatments by Patient</li>
  <li>Frequent Patients</li>
  <li>Patient Statistics</li>
</ol>

<h4>Diagnosis & Treatment</h4>

<ol>
  <li>All Diagnoses</li>
  <li>Outpatient Diagnoses</li>
  <li>Diagnosis Frequencies</li>
  <li>All Treatments</li>
  <li>Inpatient Treatments</li>
  <li>Outpatient Treatments</li>
  <li>Diagnosis & Patient Frequencies</li>
  <li>Treatment Employees</li>
</ol>

<h4>Employee Information</h4>

<ol>
  <li>All Workers</li>
  <li>Information Desk Volunteers</li>
  <li>High Frequency Primary Doctors</li>
  <li>Diagnoses by Doctor</li>
  <li>Treatment Orders by Doctor</li>
  <li>Treatment Involvment by Doctor</li>
  <li>Highly Involved Doctors</li>
</ol>
