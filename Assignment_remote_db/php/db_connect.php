<?php 
/**
 * Handling database connection
 */

 class DBConnect {
 		
	function __construct() {
		
	}
	
	function __destruct() {
		
	}
	
	/**
	 * Establishing database connection
	 */
	 public function connect() {
	 	require_once 'config.php';
		
		//Connecting to mysql database
		$conn = mysql_connect(DB_HOST, DB_USERNAME, DB_PASSWORD);
		mysql_select_db(DB_NAME);
		
		//Check for database connection error
		/*if (mysql_errno()) {
			echo "Failed to connect to MySQL: " . mysql_error();
		}*/
		
		//returing connection resource
		return $conn;
	 }
	 
	 //Closing database connection
	 public function close() {
	 	mysql_close();
	 }
 }

?>