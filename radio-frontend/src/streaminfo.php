<?php
$json = file_get_contents("http://192.168.99.100:30420/status-json.xsl");
$parsed_json = json_decode($json);
$art = $parsed_json->{'icestats'}->{'source'}->{'artist'};
$title = $parsed_json->{'icestats'}->{'source'}->{'title'};

$string = file_get_contents("http://192.168.99.100:30420/status-json.xsl");
$json_a = json_decode($string, true);

$albumArt = shell_exec('/var/www/html/node_modules/album-art/cli.js "' . $art . '" "' . $title . '"');

if ( $art == null ) {
	$current = 'Off air… Come back later :)';
	print ('&#9726; <em style="opacity:.7">' . $current . '</em>');
	print ('<style>.emb audio {display:none}</style>');
} else {
	print ('<small>now playing:</small><br>');
	print ('&#9654; Artist: ' . $art . '<br>');
	print ('&#9654; Title: ' . $title);
	print ('<img src="' . $albumArt . '">');
}

?>
