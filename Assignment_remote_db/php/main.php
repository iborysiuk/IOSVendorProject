<?php 

/**
 * check for POST request
 */

 if (isset($_POST['tag']) && $_POST['tag'] != ''){
 	//get tag
 	$tag = $_POST['tag'];
	
	//include db handler
	require_once 'db_functions.php';
	$db = new DB_Functions();
	
	//response Array
	$response = array('tag' => $tag, "success" => 0, "error" => 0);
	
	//check for tag type
	if ($tag == 'login') {
		//Request type is check login
		$email = $_POST['email'];
		$password = $_POST['password'];
		
		//check for user
		$user = $db-> getUserByEmailAndPassword($email, $password);
		if ($user !=FALSE) {
			//user found
			//echo json with success = 1
			$response["success"] = 1;
			$response["uid"] = $user["unique_id"];
			$response["user"]["name"] = $user["name"];
			$response["user"]["email"] = $user["email"];
			$response["user"]["created_at"] = $user["created_at"];
			$response["user"]["updated_at"] = $user["updated_at"];
			echo json_encode($response);
		} else {
			//user not found
			//echo json with error = 1
			$response["error"] = 1;
			$response["error_msg"] = "Incorrect email or password!";
		}
	} else if($tag == 'register') {
		//Requested type is Register new user
		$name = $_POST['name'];
		$email = $_POST['email'];
		$password = $_POST['password'];
		
		//check if user is already existed
		if ($db->isUserExisted($email)) {
			//user is already existed - error response
			$response["error"] = 2;
			$response["error_msg"] = "User already existed";
			echo json_encode($response);
		} else {
			//store user
			$user = $db->storeUser($name, $email, $password);
			if ($user) {
				//user stored successfully
				$response["success"] = 1;
				$response["uid"] = $user["unique_id"];
				$response["user"]["name"] = $user["name"];
				$response["user"]["email"] = $user["email"];
				$response["user"]["created_at"] = $user["created_at"];
				$response["user"]["updated_at"] = $user["updated_at"];
				echo json_encode($response);
			} else {
				//user failed to store
				$response["error"] = 1;
				$response["error_msg"] = "Error occurred in Registration";
				echo json_encode($response);
			}
		}
	} else if ($tag == 'add') {
	
		//Requested type is Add new vendor
		$name = $_POST['name'];
		$email = $_POST['email'];
		$phonenumber = $_POST['phonenumber'];
		$country = $_POST['country'];
		$city = $_POST['city'];
		$address = $_POST['address'];
		$postalcode = $_POST['postalcode'];
		$imgLink = $_POST['imgLink'];

		//store vendor
		$addVendor = $db->storeVendor($name, $email, $phonenumber, $country, $city, $address, $postalcode, $imgLink);
		if ($addVendor) {
			//vendor add successfully
			$response["success"] = 1;
			$response["addVendor"]["name"] = $addVendor["name"];
			$response["addVendor"]["email"] = $addVendor["email"];
			$response["addVendor"]["phonenumber"] = $addVendor["phonenumber"];
			$response["addVendor"]["country"] = $addVendor["country"];
			$response["addVendor"]["city"] = $addVendor["city"];
			$response["addVendor"]["address"] = $addVendor["address"];
			$response["addVendor"]["postalcode"] = $addVendor["postalcode"];
			$response["addVendor"]["imgLink"] = $addVendor["imgLink"];
			$response["addVendor"]["createdAt"] = $addVendor["createdAt"];
			echo json_encode($response);
		} else {
			//else vendor failed to store
			$response['error'] = 1;
			$response['error_msg'] = "Error occurred in Add a new vendor";
			echo json_encode($response);
		}
	} else if ($tag == 'vendor') {
		$vendor = $db->getAllVendors();
		
		if ($vendor != false) {
			$no_of_vendors = mysql_num_rows($vendor);
		} else {
			$no_of_vendors = 0;
		}
		
		if ($no_of_vendors > 0) {
			
			$resultArray = array();
			$tempArray = array();
			
			while($row = mysql_fetch_object($vendor)) {
				
				$tempArray = $row;
				array_push($resultArray, $tempArray);
			
			}
			echo json_encode($resultArray);
		}
	} else {
		echo "Invalid Request";
	}
 } else {
     echo "Access Denied";
 }
 
?>