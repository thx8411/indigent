<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width = device-width, initial-scale = 1">

  <title>INDIgent Webmin</title>

  <link rel="stylesheet" type="text/css" href="css/chota.css">

</head>
<body>

<div class=row>
    <div class=col>
        <h1 align=center>INDIgent Webmin</h1>
    </div>
</div>


<div class=raw>
    <fieldset id="status">
        <legend>Status :</legend>
        <iframe id="status_frame" title="INDIgent status" height=170 src="/status"></IFRAME></TD>
    </fieldset>
</div>

<div class=raw>
    <fieldset id="wifi">
        <legend>Wifi :</legend>

        <p>{{wifi_status}}
        <p>
        <p>{{wifi_channels}}

    </fieldset>
</div>

<div class=raw>
    <fieldset id="system">
        <legend>System :</legend>

        <div class="col-3">
		<form method="GET" action="/stop">
			<button style="width:250px" type="submit">Stop...</button>
		</form>
	</div>

	<div class="col-3">
		<form method="GET" action="/restart">
			<button style="width:250px" type="submit">Restart...</button>
		</form>
	</div>

	<div class="col-3">
		<form method="GET" action="/update">
			<button style="width:250px" type="submit" disabled>Update...</button>
		</form>
	</div>

	<div class="col-3">
                <form method="GET" action="/reset">
                        <button style="width:250px" type="submit" disabled>Back to factory settings...</button>
                </form>
        </div>

    </fieldset>

</div>

<hr>
INDIgent Webmin v 0.1

<script>
        window.setInterval(function() {
            reloadIFrame()
        }, 5000);

        function reloadIFrame() {
            document.getElementById('status_frame').contentWindow.location.reload();
        }
</script>

</body>
</html>
