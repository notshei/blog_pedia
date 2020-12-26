<?php

$connect = new mysqli("localhost", "root", "", "miniblog");

if ($connect) {
	# code...
	
}
else{
	echo("Connection Failed");
	exit();
}

