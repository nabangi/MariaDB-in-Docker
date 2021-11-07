#!/usr/bin/env php
<?php

$username = '[root]';
$password = '[master_root_password]';
$servers = array(
	'[adprcc3ms_mariadb-master_1]',
	'[adprcc3ms_mariadb-slave_1]',
	
);

$errors = '';

foreach($servers as $server) {
	$link = mysql_connect($server, $username, $password);
	if($link) {
		$res = mysql_query("SHOW SLAVE STATUS", $link);
		$row = mysql_fetch_assoc($res);
		if($row['Slave_IO_Running'] == 'No') {
			$errors .= "Slave IO not running on $server";
			$errors .= "Error number: {$row['Last_IO_Errno']}n"; 
			$errors .= "Error message: {$row['Last_IO_Error']}nn";
		}
		if($row['Slave_SQL_Running'] == 'No') {
			$errors .= "Slave SQL not running on $server";
			$errors .= "Error number: {$row['Last_SQL_Errno']}n";
			$errors .= "Error message: {$row['Last_SQL_Error']}nn";
		}
		mysql_close($link);
	}
	else {
		$errors .= "Could not connect to $server";
	}
}

if($errors) {
	mail('[email address]', 'MySQL slave errors', $errors);
}

?>
