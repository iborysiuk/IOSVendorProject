<?php

class DB_Functions {
	
	private $db;
	
	function __construct() {
		require_once 'db_connect.php';
		//connecting to db
		$this->db = new DBConnect();
		$this->db->connect();
	}
	
	//destructor
	function __destruct() {
		
	}
	/**
	*Storing new vendor
	*/
	public function storeVendor($name, $email, $phonenumber, $country, $city, $address, $postalcode, $imgLink) {
		$result = mysql_query("INSERT INTO vendors(name, email, phonenumber, country, city, address, postalcode, imgLink, createdAt) VALUES('$name','$email', '$phonenumber', '$country', '$city', '$address', '$postalcode', '$imgLink', NOW())");
	
	//check for successful store
	if ($result) {
			$id = mysql_insert_id();
			$result = mysql_query("SELECT * FROM vendors WHERE id = '$id'");
			return mysql_fetch_array($result);
		} else {
			return FALSE;
		}
	}
	
	//Get vendor
	public function getAllVendors() {
		$result = mysql_query("SELECT * FROM vendors");
		return $result;
	}
	
	/**
	 * Storing new user
	 */
	 
	 public function storeUser($name, $email, $password) {
	 	$uuid = uniqid('',true);
		$hash = $this->hashSSHA($password);
		$encrypted_password = $hash["encrypted"]; 
		$salt = $hash["salt"]; // salt
		$result = mysql_query("INSERT INTO users(unique_id, name, email, encrypted_password, salt, created_at) VALUES('$uuid', '$name', '$email', '$encrypted_password', '$salt', NOW())");
		//check for successful store
		if ($result) {
			$uid = mysql_insert_id();
			$result = mysql_query("SELECT * FROM users WHERE uid = $uid");
			
			return mysql_fetch_array($result);
		} else {
			return FALSE;
		}
	 }
	/**
	 * Get user by email and password
	 */
	
	public function getUserByEmailAndPassword($email, $password) {
        $result = mysql_query("SELECT * FROM users WHERE email = '$email'") or die(mysql_error());
        // check for result 
        $no_of_rows = mysql_num_rows($result);
        if ($no_of_rows > 0) {
            $result = mysql_fetch_array($result);
            $salt = $result['salt'];
            $encrypted_password = $result['encrypted_password'];
            $hash = $this->checkhashSSHA($salt, $password);
            // check for password equality
            if ($encrypted_password == $hash) {
                // user authentication details are correct
                return $result;
            }
        } else {
            // user not found
            return false;
        }
    }
	
	/**
	 * Check user is existed or not
	 */
	 public function isUserExisted($email) {
	 	$result = mysql_query("SELECT email FROM users WHERE email = '$email'");
		$no_of_rows = mysql_num_rows($result);
		if ($no_of_rows > 0) {
			//user existed
			return true;
		} else {
			//user not existed
			return false;	
		}
	 }
	 
	 /**
	  * Encrypting password
	  */
	  
	  public function hashSSHA($password) {
	  	$salt = sha1(rand());
		$salt = substr($salt, 0, 10);
		$encrypted = base64_encode(sha1($password . $salt, TRUE) . $salt);
		$hash = array("salt" => $salt, "encrypted" => $encrypted);
		return $hash;
	  }
	  
	  /**
	   * Decrypting password
	   */
		public function checkhashSSHA($salt, $password) {
		
			$hash = base64_encode(sha1($password . $salt, TRUE) . $salt);
			
			return $hash;
		}
}


?>