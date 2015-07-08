<?php

$mysqli = new mysqli("172.16.60.129", "root", "linux", "hospital");

if ($mysqli->connect_errno) {
    echo "Failed to connect to MySQL: " . $mysqli->connect_errno . " -> " . $mysqli->connect_error;
}

printf("<table>");

printf("<tr><th>Number</th><th>Name</th></tr>");

$res = $mysqli->query("SELECT * FROM workers;");

while ($row = $res->fetch_array()) {

  printf("<tr><td>%s</td><td>%s</td></tr>", $row[0], $row[1]);

}

printf("</table>");

?>
