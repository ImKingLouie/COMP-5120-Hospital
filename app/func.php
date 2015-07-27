<?php
	function fetch($q){
		$dbc=new mysqli("acadmysql.duc.auburn.edu","comp5120g2","pw4g2!","hospital");
		if($dbc->connect_error)
			die("SQL CONNECTION FAILURE: ".$dbc->connect_error);
		$r=$dbc->query($q);
		if(!$r)
			die("SQL ERROR: ".$dbc->error);
		$arr=array();
		while($row=$r->fetch_array(MYSQLI_ASSOC))
			array_push($arr,$row);
		$r->free();
		$dbc->close();
		return $arr;
	}
	function a1(){
		return fetch(
			"
				SELECT r.room_id,CONCAT(p.lname,', ',p.fname) patient_name,DATE(a.timestamp) admission_date
				FROM rooms r JOIN admissions a ON r.admission_id=a.admission_id
				JOIN patients p ON p.patient_id=a.patient_id WHERE r.admission_id IS NOT NULL;
			"
		);
	}
	function a2(){
		return fetch(
			"
				SELECT room_id
				FROM rooms
				WHERE admission_id IS NULL;
			"
		);
	}
	function a3(){
		return fetch(
			"
				SELECT r.room_id,CONCAT(p.lname,', ',p.fname) patient_name,DATE(a.timestamp) admission_date
				FROM rooms r LEFT JOIN admissions a ON r.admission_id=a.admission_id
				LEFT JOIN patients p ON p.patient_id=a.patient_id;
			"
		);
	}
	function b1(){
		return fetch(
			"
				SELECT * FROM patients;
			"
		);
	}
	function b2(){
		return fetch(
			"
				SELECT p.patient_id,CONCAT(p.lname,', ',p.fname) patient_name
				FROM admissions a JOIN patients p ON a.patient_id=p.patient_id
				WHERE a.status='active' GROUP BY a.patient_id;
			"
		);
	}
	function b3($f1,$f2){
		return fetch(
			"
				SELECT p.patient_id,CONCAT(p.lname,', ',p.fname) patient_name
				FROM admissions a JOIN patients p ON a.patient_id=p.patient_id
				WHERE a.timestamp BETWEEN DATE('".$f1."') AND DATE ('".$f2."')
				GROUP BY a.patient_id;
			"
		);
	}
	function b4($f1,$f2){
		return fetch(
			"
				SELECT p.patient_id,CONCAT(p.lname,', ',p.fname) patient_name
				FROM discharges d JOIN admissions a ON d.admission_id=a.admission_id
				JOIN patients p ON a.patient_id=p.patient_id
				WHERE a.timestamp BETWEEN DATE('".$f1."') AND DATE('".$f2."')
				GROUP BY p.patient_id;
			"
		);
	}
	function b5(){
		return fetch(
			"
				SELECT p.patient_id,CONCAT(p.lname,', ',p.fname) patient_name
				FROM outpatient_orders o JOIN patients p ON o.patient_id=p.patient_id
				WHERE o.end_date > NOW() OR o.end_date IS NULL;
			"
		);
	}
	function b6($f1,$f2){
		return fetch(
			"
				SELECT p.patient_id,CONCAT(p.lname,', ',p.fname) patient_name
				FROM outpatient_orders o JOIN patients p ON o.patient_id=p.patient_id
				WHERE start_date BETWEEN DATE('".$f1."') AND DATE('".$f2."');
			"
		);
	}
	function b7($f1){
		return fetch(
			"
				SELECT a.admission_id,CONCAT(p.lname,', ',p.fname) patient_name,DATE(a.timestamp) admission_date,d.name
				FROM admissions a JOIN patients p ON a.patient_id=p.patient_id
				JOIN diagnoses d ON a.diagnosis_id=d.diagnosis_id
				WHERE a.patient_id='".$f1."' OR p.fname='".$f1."';
			"
		);
	}
	function b8($f1){
		return fetch(
			"
				SELECT a.admission_id,p.patient_id,CONCAT(p.lname,', ',p.fname) patient_name,t.name patient_name
				FROM administered_treatments at JOIN treatment_orders o ON at.order_id=o.order_id
				JOIN admissions a ON o.admission_id=a.admission_id
				JOIN treatments t ON o.treatment_id=t.treatment_id
				JOIN patients p ON a.patient_id=p.patient_id
				WHERE a.patient_id='".$f1."' OR p.fname='".$f1."'
				GROUP BY admission_id ORDER BY a.timestamp;
			"
		);
	}
	function b9(){
		return fetch(
			"
				SELECT a.patient_id, fname, lname, doctor_id, diagnosis_id
				FROM discharges d NATURAL JOIN admissions a
				NATURAL JOIN patients p JOIN (
					SELECT patient_id, MAX(discharges.timestamp) AS enddate
					FROM discharges NATURAL JOIN admissions
					GROUP BY patient_id) AS r1
					WHERE a.patient_id=r1.patient_id AND d.timestamp=r1.enddate
					AND DATEDIFF(r1.enddate, a.timestamp)>=30;
			"
		);
	}
	function b10(){
		return fetch(
			"
				SELECT patient_id,num,avg_duration,max_span,min_span,avg_span
				FROM(
					SELECT patient_id,COUNT(*) num
					FROM admissions GROUP BY patient_id
				) r1 NATURAL JOIN (
					SELECT patient_id, AVG(DATEDIFF(d.timestamp,a.timestamp)) avg_duration
					FROM admissions a JOIN discharges d USING(admission_id) GROUP BY patient_id
				) r2 NATURAL JOIN (
					SELECT patient_id, MAX(DATEDIFF(date1, date2)) max_span
					FROM (
						SELECT patient_id, d.timestamp date2, MIN(a2.timestamp) date1
						FROM discharges d NATURAL JOIN admissions a1 JOIN admissions a2
						USING(patient_id) WHERE a2.timestamp>=d.timestamp
						GROUP BY patient_id, d.timestamp
					) r GROUP BY patient_id
				) r3 NATURAL JOIN (
					SELECT patient_id, MIN(DATEDIFF(date1,date2)) min_span
					FROM (
						SELECT patient_id, d.timestamp date2, MIN(a2.timestamp) date1
						FROM discharges d NATURAL JOIN admissions a1 JOIN admissions a2
						USING(patient_id) WHERE a2.timestamp>=d.timestamp
						GROUP BY patient_id, d.timestamp
					) r GROUP BY patient_id
				) r4 NATURAL JOIN (
					SELECT patient_id, AVG(DATEDIFF(date1,date2)) avg_span
					FROM (
						SELECT patient_id,d.timestamp date2, MIN(a2.timestamp) date1
						FROM discharges d NATURAL JOIN admissions a1 JOIN admissions a2
						USING(patient_id) WHERE a2.timestamp >= d.timestamp
						GROUP BY patient_id, d.timestamp
					) r GROUP BY patient_id
				) r5;
			"
		);
	}
	function c1(){
		return fetch(
			"
				SELECT a.diagnosis_id,b.name,COUNT(b.name) AS occurance
				FROM admissions a, diagnoses b
				WHERE a.diagnosis_id=b.diagnosis_id
				GROUP BY b.name
				ORDER BY occurance DESC;
			"
		);
	}
	function c2(){
		return fetch(
			"
				SELECT a.diagnosis_id,b.name,COUNT(b.name) AS occurance
				FROM outpatient_orders a
				JOIN diagnoses b ON a.diagnosis_id=b.diagnosis_id
				GROUP BY b.name
				ORDER BY occurance DESC;
			"
		);
	}
	function c3(){
		return fetch(
			"
				SELECT a.diagnosis_id,b.name,COUNT(b.name) AS occurance
				FROM (
					SELECT admissions.diagnosis_id AS diagnosis_id
					FROM admissions UNION SELECT outpatient_orders.diagnosis_id AS diagnosis_id
					FROM outpatient_orders) AS a
					JOIN diagnoses b ON a.diagnosis_id=b.diagnosis_id
					GROUP BY b.name
					ORDER BY occurance desc;
			"
		);
	}
	function c4(){
		return fetch(
			"
				SELECT a.treatment_id, b.name, COUNT(b.name) AS occurance
				FROM treatment_orders a JOIN treatments b ON a.treatment_id=b.treatment_id
				GROUP BY b.name ORDER BY occurance DESC;
			"
		);
	}
	function c5(){
		return fetch(
			"
				SELECT a.treatment_id, b.name, COUNT(b.name) AS occurance
				FROM treatment_orders a JOIN treatments b ON a.treatment_id=b.treatment_id
				WHERE a.patient_id IS NULL
				GROUP BY b.name ORDER BY occurance DESC;
			"
		);
	}
	function c6(){
		return fetch(
			"
				SELECT a.treatment_id, b.name, COUNT(b.name) AS occurance
				FROM treatment_orders a JOIN treatments b ON a.treatment_id=b.treatment_id
				WHERE a.admission_id IS NULL
				GROUP BY b.name ORDER BY occurance DESC;
			"
		);
	}
	function c7(){
		return fetch(
			"
				SELECT final.name
				FROM (
					SELECT a.admission_id,a.diagnosis_id,b.name,COUNT(b.diagnosis_id)
					FROM admissions a join (
						SELECT t2.patient_id, COUNT(t2.admission_id) AS occurance
						FROM admissions t2
						GROUP BY t2.patient_id
						HAVING occurance=(
							SELECT COUNT(t1.admission_id) AS count_num
							FROM admissions t1
							GROUP BY t1.patient_id ORDER BY count_num DESC LIMIT 1
						) 
					) AS patient_need ON a.patient_id=patient_need.patient_id
					JOIN diagnoses b ON a.diagnosis_id=b.diagnosis_id
					GROUP BY b.diagnosis_id
					ORDER BY COUNT(b.diagnosis_id) DESC
				) AS final;
			"
		);
	}
	function c8(){
		return fetch(
			"
				SELECT CONCAT(a.lname,', ',a.fname) AS name
				FROM treatment_orders t JOIN patients a ON t.patient_id=a.patient_id
				UNION SELECT CONCAT(b.lname,', ',b.fname) AS name
				FROM treatment_orders t JOIN workers b ON t.doctor_id=b.worker_id
				UNION SELECT CONCAT(b.lname,', ',b.fname) AS name
				FROM treatment_orders t JOIN administered_treatments c ON c.order_id=t.order_id
				JOIN workers b ON c.treatment_admin_id=b.worker_id;
			"
		);
	}
	function d1(){
		return fetch(
			"
				SELECT worker_id,fname,lname,'Staff' AS job_category, hire_date
				FROM workers JOIN staff ON staff.staff_id=workers.worker_id
				UNION SELECT worker_id,fname,lname,'Administrator' AS job_category, hire_date
				FROM workers JOIN administrators ON administrators.administrator_id=workers.worker_id
				UNION SELECT worker_id,fname,lname,'Technician' AS job_category, hire_date
				FROM workers JOIN technicians ON technicians.technician_id=workers.worker_id
				UNION SELECT worker_id,fname,lname,'Nurse' AS job_category,hire_date
				FROM workers JOIN nurses ON nurses.nurse_id=workers.worker_id
				UNION SELECT worker_id,fname,lname,'Doctor' AS job_category, hire_date
				FROM workers JOIN doctors ON doctors.doctor_id=workers.worker_id
				ORDER BY lname,fname;
			"
		);
	}
	function d2(){
		return fetch(
			"
				SELECT * FROM services JOIN volunteer_schedules ON volunteer_schedules.service_id=services.service_id
				WHERE services.name='Information Desk' AND volunteer_schedules.day='tuesday';
			"
		);
	}
	function d3(){
		return fetch(
			"
				SELECT a.doctor_id, CONCAT(w.lname,', ',w.fname) doctor_name
				FROM admissions a JOIN (
					SELECT patient_id, COUNT(*) num_admissions, MIN(timestamp) earliest_admission, DATEDIFF(NOW(),MIN(timestamp))
					FROM admissions GROUP BY patient_id HAVING DATEDIFF(NOW(),earliest_admission)<365 AND num_admissions>=4
				) b ON a.patient_id=b.patient_id
				JOIN workers w ON w.worker_id=a.doctor_id
				JOIN patients p ON p.patient_id=a.patient_id
				GROUP BY a.doctor_id;
			"
		);
	}
	function d4($f1){
		return fetch(
			"
				SELECT d.name, COUNT(*) diagnosis_count
				FROM admissions a JOIN diagnoses d ON a.diagnosis_id=d.diagnosis_id
				WHERE a.doctor_id='".$f1."'
				GROUP BY a.diagnosis_id
				UNION SELECT d.name, COUNT(*) diagnosis_count
				FROM outpatient_orders o JOIN diagnoses d ON o.diagnosis_id=d.diagnosis_id
				WHERE o.doctor_id='".$f1."'
				GROUP BY o.diagnosis_id;
			"
		);
	}
	function d5($f1){
		return fetch(
			"
				SELECT t.name, COUNT(*) treatment_count
				FROM treatment_orders o JOIN treatments t ON o.treatment_id=t.treatment_id
				WHERE o.doctor_id='".$f1."'
				GROUP BY o.treatment_id;
			"
		);
	}
	function d6($f1){
		return fetch(
			"
				SELECT t.name,COUNT(*) participation_count
				FROM administered_treatments a JOIN treatment_orders o ON a.order_id=o.order_id
				JOIN treatments t ON o.treatment_id=t.treatment_id
				WHERE doctor_id='".$f1."'
				GROUP BY o.treatment_id ORDER BY participation_count DESC;
			"
		);
	}
	function d7(){
		return fetch(
			"
				SELECT employee_id
				FROM employees e WHERE NOT EXISTS (
					SELECT * FROM (
						SELECT patient_id
						FROM treatment_orders
					) p WHERE NOT EXISTS (
						SELECT * FROM ((
							SELECT doctor_id eid, patient_id
							FROM treatment_orders
						) UNION (
							SELECT treatment_admin_id eid,patient_id
							FROM treatment_orders NATURAL JOIN administered_treatments
						)) r WHERE r.eid=e.employee_id AND p.patient_id=r.patient_id
					)
				);
			"
		);
	}
?>
