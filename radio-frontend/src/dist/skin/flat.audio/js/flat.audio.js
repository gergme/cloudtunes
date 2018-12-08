jQuery(document).ready(function($) {
	$("#jquery_jplayer_1").jPlayer({
		ready: function(event) {
			$(this).jPlayer("setMedia", {
				mp3: "http://jplayer.org/audio/mp3/Miaow-02-Hidden.mp3",
				oga: "http://jplayer.org/audio/ogg/Miaow-02-Hidden.ogg"
			});
		},
		timeFormat: {
			padMin: false
		},
		swfPath: "js",
		supplied: "mp3,oga",
		smoothPlayBar: true,
		keyEnabled: true,
		keyBindings: {
			// Disable some of the default key controls
			muted: null,
			volumeUp: null,
			volumeDown: null
		},
		wmode: "window"
	});
});
