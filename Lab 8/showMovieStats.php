<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8"/>
      <title>Show Movie Stats</title>
   </head>
   <body>

   <!-- Edit the link -->
   <a href='http://linux.students.engr.scu.edu/~jlin3/showMovieStats.php?show=true'>Show Movie Stats</a>
   <br><br>
<?php

if (isset($_GET['show'])) {
    showStats();
}

function showStats(){
	//connect to your database. Type in your username, password and the DB path
	
	$conn = oci_connect('jlin3', 'z2n3o87s', '//dbserver.engr.scu.edu/db11g');
	if (!$conn) {
		$e = oci_error();
		trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
	} 
	if(!$conn) {
	     print "<br> connection failed:";
        exit;
	}
	// Query to find the name of movie and the no. of reviews per movie
	$query1 = oci_parse($conn, "SELECT movieName, Count(*) NoOfReviews FROM MovieReviews Group by movieName");

	// Execute the query
	oci_execute($query1);
	
	// Now access each row fetched in the loop
	while (($row = oci_fetch_array($query1, OCI_BOTH)) != false) {
		// We can use either numeric indexed starting at 0
		// or the column name as an associative array index to access the colum value
		// Use the uppercase column names for the associative array indices
		echo "<font color='black'>Movie: </font>";
		echo "<font color='green'>  $row[0] </font>";
		echo "<font color='black'>No. of Reviews: </font> <font color='red'> $row[1]</font></br>";		
	}
	
	/* Write your query 2 here to find the name of the movie(s) 
	with maximum no. of reviews.
	oci_execute($query2);
	*/
	
	// Query to find the name of movie and the no. of reviews per movie
	$query2 = oci_parse($conn, "Select movieName, count(movieName) NoOfReviews FROM MovieReviews GROUP BY movieName HAVING COUNT(movieName) >= ALL(SELECT Count(movieName) FROM MovieReviews Group by movieName)");


	// Execute the query
	oci_execute($query2);
	
	// Now access each row fetched in the loop
	while (($row = oci_fetch_array($query2, OCI_BOTH)) != false) {
		// We can use either numeric indexed starting at 0
		// or the column name as an associative array index to access the colum value
		// Use the uppercase column names for the associative array indices
		echo "<font color='blue'> Movie(s) with the most no. of reviews </font>";
		echo "<font color='black'>Movie: </font>";
		echo "<font color='green'>  $row[0] </font>";
		echo "<font color='black'>No. of Reviews: </font> <font color='red'> $row[1]</font></br>";		
	}

	OCILogoff($conn);
}
?>
<!-- end PHP script -->
   </body>
</html>
