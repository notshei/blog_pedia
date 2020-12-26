<?php
include 'conn.php';

//$queryResult = $connect->query("SELECT * FROM post p JOIN users u ON p.idpenulis = u.id ORDER BY p.idpost DESC");
// $queryResult = $connect->query("SELECT DISTINCT * FROM users u JOIN post p ON u.id = p.idpenulis JOIN kategori k ON p.idkategori = k.id JOIN komentar ko ON p.idpost = ko.idpost");

// $queryResult = $connect->query("SELECT k.comment from komentar k join post p on k.idpost = p.idpost where p.idpost in (select DISTINCT idpost from komentar) ");
$queryResult = $connect->query("SELECT * FROM komentar");

$result = array();

while ($fetchData = $queryResult->fetch_assoc()) {
	# code...
	$result[]=$fetchData;
}

echo json_encode($result);

?>