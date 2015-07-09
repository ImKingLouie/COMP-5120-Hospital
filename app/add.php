<?php

$mysqli = new mysqli("172.16.60.129", "root", "linux", "hospital");

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: " . $mysqli->connect_errno . " -> " . $mysqli->connect_error;
}

function basic_table_dl($mysqli, $table_name, $key, $value) {

  $select = sprintf("<select name='%s'>", $table_name);

  $q = sprintf("SELECT * FROM %s;", $table_name);

  $res = $mysqli->query($q);

  while ($row = $res->fetch_array()) {

    $select .= sprintf("<option value='%s'>%s</option>", $row[$key], $row[$value]);

  }

  $select .= "</select>";

  return $select;

}

function join_table_dl($mysqli, $table_name1, $table_name2, $id1, $id2, $key, $value, $name = rand()) {

  $select = sprintf("<select name='%s'>", $table_name1);

  $q = sprintf("SELECT * FROM %s JOIN %s ON %s.%s = %s.%s;", $table_name1, $table_name2, $table_name1, $id1, $table_name2, $id2);
echo $q;

  $res = $mysqli->query($q);

  while ($row = $res->fetch_array()) {

    $select .= sprintf("<option value='%s'>%s</option>", $row[$key], $row[$value]);

  }

  $select .= "</select>";

  return $select;

}

if($_POST['insert']) {

  var_dump($_POST);

  printf("Posted...");

  $table_name = array_pop($_POST);
  $remove_button = array_pop($_POST);

  $cols_sql = sprintf("SELECT column_name FROM information_schema.columns WHERE table_schema='hospital' AND table_name = '%s' LIMIT %s;", $table_name, count($_POST));

  $cols = $mysqli->query($cols_sql);

  while($key = $cols->fetch_array()) {

    $keys[] = $key[0];

  }

  foreach($_POST as $key => $value) {

    printf("<h3>%s</h3>", $value);

    $values[] = $value;

  }

  $q = sprintf("INSERT INTO %s (%s) VALUES(%s);", $table_name, implode(", ", $keys), implode(", ", $values));

  printf("<p>SQL: %s</p>", $q);

  $res = $mysqli->query($q);

  if($res) {
    print 'OK. Rows affected: ' .$mysqli->insert_id .'<br />';
  } else {
    die('<p>Error : ('. $mysqli->errno .') '. $mysqli->error . '</p>');
  }

  var_dump($_POST);
  echo count($POST);

}


printf("<h3>Assign Doctor</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<br>Doctor: ");
printf(join_table_dl($mysqli, "doctors", "workers", "wid", "wid", 0, 3));
printf("<br>Admission: ");
printf(join_table_dl($mysqli, "admissions", "patients", "patient_pid", "pid", 0, 7));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='assigned_doctors'>");
printf("</form>");

printf("<h3>Add Order</h3>");
printf("<form action='%s' method='POST'>", $_SERVER['PHP_SELF']);
printf("<input type='hidden' name='order_id' value='NULL'>");
printf("<br>Doctor: ");
printf(join_table_dl($mysqli, "assigned_doctors", "workers", "assigned_doctors_wid",  "wid", 0, 3));
printf("<br>Admission: ");
printf(join_table_dl($mysqli, "assigned_doctors", "admissions", "assigned_admission_id", "admission_id", 0, 1));
printf("<br>Treatment Administrator: ");
printf(basic_table_dl($mysqli, "treatment_administrator_workers", 0, 1));
printf("<br>Treatment: ");
printf(basic_table_dl($mysqli, "treatments", 0, 1));
printf("<br><input type='submit' name='insert'>");
printf("<input type='hidden' name='table_name' value='orders'>");
printf("</form>");

?>
