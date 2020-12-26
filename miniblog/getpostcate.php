<?php
include 'conn.php';

//$get = $_GET['idkategori'];

 $queryResult = $connect->query("SELECT * FROM kategori k JOIN post p ON k.id = p.idkategori JOIN users u ON p.idpenulis = u.id ORDER BY p.idpost DESC");
//$queryResult = $connect->query("SELECT * FROM kategori k JOIN post p ON k.id = p.idkategori WHERE p.idkategori = k.id");

$result = array();

while ($fetchData = $queryResult->fetch_assoc()) {
	# code...
	$result[]=$fetchData;
}

echo json_encode($result);

?>