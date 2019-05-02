<?php
error_reporting(0);
$m = new Memcached();
$m->addServer('192.168.99.100', 31211) or die ("Cannot connect to memcached!");
$json = file_get_contents("http://192.168.99.100:30420/status-json.xsl");
$parsed_json = json_decode($json);
$art = $parsed_json->{'icestats'}->{'source'}->{'artist'};
$title = $parsed_json->{'icestats'}->{'source'}->{'title'};
//$album = $parsed_json->{'icestats'}->{'source'}->{'album'};
$cacheArt = $m->get('artist');
$cacheTitle = $m->get('title');
//$cacheAlbum = $m->get('album');
$string = file_get_contents("http://192.168.99.100:30420/status-json.xsl");
$json_a = json_decode($string, true);

if ( $title != $cacheTitle OR $cacheTitle == null) {
	$m->set('changed', true);
	$m->set('artist', $art);
	$m->set('title', $title);
	//$m->set('album', $album);
	$cacheArt = $m->get('artist');
	$cacheTitle = $m->get('title');
	//$cacheAlbum = $m->get('album');
	//$fetchArt = shell_exec('/var/www/html/node_modules/album-art/cli.js "' . $cacheArt . '" "' . $cacheTitle . '"');
	//file_put_contents("img/currentAlbum.png", fopen($fetchArt, 'r+'));
} else {
	$m->set('changed', false);
}

// Output
print ('<small>now playing:</small><br>');
print ('&#9654; Artist: ' . $cacheArt . '<br>');
print ('&#9654; Title: ' . $cacheTitle . '<br>');
?>
