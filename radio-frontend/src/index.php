<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<!-- Website Design By: www.happyworm.com -->
<title>Default Radio Station [Demo]</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- <link href="dist/skin/blue.monday/css/jplayer.blue.monday.min.css" rel="stylesheet" type="text/css" /> -->
<link href="dist/skin/flat.audio/css/flat.audio.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="lib/jquery.min.js"></script>
<script type="text/javascript" src="dist/jplayer/jquery.jplayer.min.js"></script>
<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){

	var stream = {
		title: "Demo Radio Station",
		oga: "http://192.168.99.100:30420/default0.ogg"
	},
	ready = false;

	$("#jquery_jplayer_1").jPlayer({
		ready: function (event) {
			ready = true;
			$(this).jPlayer("setMedia", stream);
		},
		pause: function() {
			$(this).jPlayer("clearMedia");
		},
		error: function(event) {
			if(ready && event.jPlayer.error.type === $.jPlayer.error.URL_NOT_SET) {
				// Setup the media stream again and play it.
				$(this).jPlayer("setMedia", stream).jPlayer("play");
			}
		},
		swfPath: "../../dist/jplayer",
		supplied: "oga",
		preload: "none",
		wmode: "window",
		useStateClassSkin: true,
		autoBlur: false,
		keyEnabled: true
	});

});
//]]>
</script>
<script type="text/javascript">
$(document).ready(function(){
setInterval(function(){
//$("#jp-nowplaying").load('streaminfo.php'),
$("#jp-box").load(location.href + " #jp-box");
}, 15000);
});
</script>
</head>
<body>

<div id="jquery_jplayer_1" class="jp-jplayer"></div>
<div id="jp_container_1" class="jp-audio">
	<div class="jp-controls">
		<a class="jp-play"></a>
		<a class="jp-pause"></a>
	</div>
	<div class="jp-bar">
		<div class="jp-seek-bar">
			<!-- <div class="jp-play-bar"></div> -->
			<div class="jp-duration"></div>
			<div class="jp-title">&nbsp;</div>
		</div>
	</div>
</div>
<div id="jp_container_1" class="jp-audio">
	<div id="jp-box" class="jp-box" style="background-image:url('<?php require_once "albumart.php"; ?>'); background-repeat: no-repeat; background-position: center bottom;">
		<div id="jp-nowplaying" class="jp-title"><?php require_once "streaminfo.php"; ?></div>
	</div>
	<div class="jp-no-solution">
		Media Player Error<br />
		Update your browser or Flash plugin
	</div>
</div>
</body>
</html>
