<?php
	require_once(__DIR__ . "/func.php");
	$arr=false;
	if(isset($_POST["submit"]))
		switch($_POST["category"]){
			case "rooms":
				switch($_POST["number"]){
					case 1:
						$arr=a1();
					break;
					case 2:
						$arr=a2();
					break;
					case 3:
						$arr=a3();
					break;
					default:
					die("invalid post");
				}
			break;
			case "patients":
				switch($_POST["number"]){
					case 1:
						$arr=b1();
					break;
					case 2:
						$arr=b2();
					break;
					case 3:
						$arr=b3($_POST["f1"],$_POST["f2"]);
					break;
					case 4:
						$arr=b4($_POST["f1"],$_POST["f2"]);
					break;
					case 5:
						$arr=b5();
					break;
					case 6:
						$arr=b6($_POST["f1"],$_POST["f2"]);
					break;
					case 7:
						$arr=b7($_POST["f1"]);
					break;
					case 8:
						$arr=b8($_POST["f1"]);
					break;
					case 9:
						$arr=b9();
					break;
					case 10:
						$arr=b10();
					break;
					default:
					die("invalid post");
				}
			break;
			case "treatments":
				switch($_POST["number"]){
					case 1:
						$arr=c1();
					break;
					case 2:
						$arr=c2();
					break;
					case 3:
						$arr=c3();
					break;
					case 4:
						$arr=c4();
					break;
					case 5:
						$arr=c5();
					break;
					case 6:
						$arr=c6();
					break;
					case 7:
						$arr=c7();
					break;
					case 8:
						$arr=c8();
					break;
					default:
					die("invalid post");
				}
			break;
			case "employees":
				switch($_POST["number"]){
					case 1:
						$arr=d1();
					break;
					case 2:
						$arr=d2();
					break;
					case 3:
						$arr=d3();
					break;
					case 4:
						$arr=d4($_POST["f1"]);
					break;
					case 5:
						$arr=d5($_POST["f1"]);
					break;
					case 6:
						$arr=d6($_POST["f1"]);
					break;
					case 7:
						$arr=d7();
					break;
					default:
					die("invalid post");
				}
			break;
			default:
			die("invalid post");
		}
?>
<html>
<head>
	<title>Brookhaven Hospital</title>
	<style>
		tr:nth-child(even){
			background-color:lightgray;
		}
	</style>
</head>
<body>
	<form id="search" method="post" enctype="multipart/form-data" action="search.php"></form>
	<table id="results">
<?php
//if there is data to print
	if($arr){
	//print headers
		echo"<tr>";
		foreach(array_keys($arr[0]) as $row)
			echo"<td>".$row."</td>";
		echo"</tr>";
	//print data under headers
		foreach($arr as $row){
			echo"<tr>";
				foreach($row as $col){
					echo"<td>".$col."</td>";
				}
			echo"</tr>";
		}
	}
?>
	</table>
	<script type="text/javascript">
		(function(parent){
		//problem categories and numbers
			var categories={
				rooms:3,
				patients:10,
				treatments:8,
				employees:7
			},
		//select element for problem category
			category=document.createElement("select"),
		//select element for problem number
			number=document.createElement("select"),
		//submit button
			submit=document.createElement("input"),
		//two text inputs
			f1=document.createElement("input"),
			f2=document.createElement("input");
		//add option elements to select elements
			function addOption(s,v,t){
				var o=document.createElement("option");
				o.value=v;o.innerHTML=t;
				s.appendChild(o);
			}
		//appropriately display extra text boxes if number or category is changed
			function showBoxes(){
				if(f1.parentNode==parent)
					parent.removeChild(f1);
				if(f2.parentNode==parent)
					parent.removeChild(f2);
				switch(category.value){
					case "patients":
						switch(parseInt(number.value)){
							case 3:case 4:case 6:
								f1.placeholder="start date";
								parent.insertBefore(f1,submit);
								f2.placeholder="end date";
								parent.insertBefore(f2,submit);
							break;
							case 7:case 8:
								f1.placeholder="patient name or id";
								parent.insertBefore(f1,submit);
							break;
						}
					break;
					case "employees":
						switch(parseInt(number.value)){
							case 4:case 5:case 6:
								f1.placeholder="doctor name or id";
								parent.insertBefore(f1,submit);
							break;
						}
					break;
				}
			}
		//repopulate number select element if category select element is changed
			function switchCategory(){
				while(number.firstChild)
					number.removeChild(number.firstChild);
				for(var i=1;i<=categories[category.value];i++)
					addOption(number,i,i);
				showBoxes();
			}
			submit.type="submit";submit.name="submit";submit.value="submit";
			category.name="category";number.name="number";
			f1.type="text";f1.name="f1";f2.type="text";f2.name="f2";
		//populate the category select element
			for(var key in categories)
				addOption(category,key,key);
			switchCategory();
		//initialize listener for category select element's onchange event
			category.onchange=switchCategory;
			number.onchange=showBoxes;
		//append select elements to the parent form
			parent.appendChild(category);
			parent.appendChild(number);
			parent.appendChild(submit);
		}(document.getElementById("search")));
	</script>
</body>
</html>
