<!DOCTYPE html>
<html lang="en">
<head>
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<base href="bin-haxe/bin/">
	
	<title>FLAPPY_BIRD</title>
	
	<meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	
	
	<link rel="shortcut icon" type="image/png" href="../../favicon.png">
	
	
	<script type="text/javascript" src="./lib/howler.min.js"></script>
	<script type="text/javascript" src="./lib/pako.min.js"></script>
	<script type="text/javascript" src="./FLAPPYBIRD.js"></script>
	<script type="text/javascript" src="../../script.js"></script>
	
	<link rel="stylesheet" type="text/css" href="../../game.css">
	
	<script>
		window.addEventListener ("touchmove", function (event) { event.preventDefault (); }, false);
		if (typeof window.devicePixelRatio != 'undefined' && window.devicePixelRatio > 2) {
			var meta = document.getElementById ("viewport");
			meta.setAttribute ('content', 'width=device-width, initial-scale=' + (2 / window.devicePixelRatio) + ', user-scalable=no');
		}
	</script>
	
	
</head>
<body>
	
	<noscript>This webpage makes extensive use of JavaScript. Please enable JavaScript in your web browser to view this page.</noscript>
	
	<div id="openfl-content"></div>
	<script type="text/javascript">
		lime.embed ("FLAPPYBIRD", "openfl-content", 0, 0, { parameters: {} });
	</script>
	
</body>
</html>
