<?php
	function fetch($q){
		$dbc=new mysql("172.16.60.129","root","linux","hospital");
		if($dbc->connect_error)
			die("SQL CONNECTION FAILURE: ".$dbc->connect_error);
		$r=mysql_query($dbc,$q)
		if(mysql_num_rows($r)<=0)
			die("SQL ERROR: ".mysql_error($dbc));
		$arr=array();
		while($row=mysql_fetch_array($r,MYSQL_ASSOC))
			array_push($arr,$row);
		mysql_free_result($r);
		return $arr;
	}
	function a1(){
		return fetch(
			"
				
			"
		);
	}
	function a2(){
	}
	function a3(){
	}
	function b1(){
	}
	function b2(){
	}
	function b3(){
	}
	function b4(){
	}
	function b5(){
	}
	function b6(){
	}
	function b7(){
	}
	function b8(){
	}
	function b9(){
	}
	function b10(){
	}
	function c1(){
	}
	function c2(){
	}
	function c3(){
	}
	function c4(){
	}
	function c5(){
	}
	function c6(){
	}
	function c7(){
	}
	function c8(){
	}
	function d1(){
	}
	function d2(){
	}
	function d3(){
	}
	function d4(){
	}
	function d5(){
	}
	function d6(){
	}
	function d7(){
	}
?>
