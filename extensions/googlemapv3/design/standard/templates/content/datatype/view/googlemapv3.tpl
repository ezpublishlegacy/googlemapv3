{*{$attribute.content|attribute(show)}*}

{def $__dimension_fe_googlemapv3 = ezini( 'Googlemapv3Settings', 'mapFrontEndDimension', 'googlemapv3.ini' )}
{def $__default_googlemapv3 = ezini( 'Googlemapv3Settings', 'mapPosition', 'googlemapv3.ini' )}
{def $__default_googlemapv3_text = ezini( 'Googlemapv3Settings', 'textForntEnd', 'googlemapv3.ini' )}

{def $__LATITUDE = $attribute.content.latitude}
{def $__LONGITUDE = $attribute.content.longitude}
{def $__ZOOM = $attribute.content.zoom}
{def $__SHOW = $attribute.content.show}
{def $__TEXT = $attribute.content.text}
{def $__MAPTYPE = $attribute.content.map_type}

{def $__HEIGHT = $attribute.content.height}
{def $__WIDTH = $attribute.content.width}
{def $__ENABLE_DIRECTION = false()}
{def $__LABEL_START = $__default_googlemapv3_text['label']}
{def $__EXAMPLE = $__default_googlemapv3_text['example']}
{def $__BUTTON_SEND = $__default_googlemapv3_text['button']}
{def $__START_FORM_HERE = ''}
{if ezhttp_hasvariable("start_form_here")}
	{set $__START_FORM_HERE = ezhttp("start_form_here")}
{/if}

{def $__LANGUAGE = $attribute.content.output_language|downcase()}
{def $__UNITY_SISTEM = $attribute.content.unity_system}

{if $attribute.content.enable_directions|eq('yes')}
	{set $__ENABLE_DIRECTION = true()}
{/if}

{if or($__HEIGHT|is_numeric()|not(),$__HEIGHT|eq(0))}
	{set $__HEIGHT = $__dimension_fe_googlemapv3['height']}
{/if}

{if or($__WIDTH|is_numeric()|not(),$__WIDTH|eq(0))}
	{set $__WIDTH = $__dimension_fe_googlemapv3['width']}
{/if}

{if $__LATITUDE|is_numeric()|not()}
	{set $__LATITUDE = $__default_googlemapv3['latitude']}
{/if}
{if $__LONGITUDE|is_numeric()|not()}
	{set $__LONGITUDE = $__default_googlemapv3['longitude']}
{/if}

{if $__ZOOM|eq(0)}
	{set $__ZOOM = $__default_googlemapv3['zoom']}
{/if}

{set $__TEXT = concat("'",$__TEXT,"'")}

<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false{if $__LANGUAGE|ne('')}&language={$__LANGUAGE}{/if}"></script>

<script type="text/javascript">
	var __latitude = {$__LATITUDE};
	var __lungidute = {$__LONGITUDE};
	var __zoom = {$__ZOOM};
	{if $__ENABLE_DIRECTION}
	var directionDisplay;
	var directionsService = new google.maps.DirectionsService();
	{/if}

	function initialize()
	{ldelim}
		{if $__ENABLE_DIRECTION}
			{if $__START_FORM_HERE|count_chars()|gt(0)}
			calcRoute();
			directionsDisplay = new google.maps.DirectionsRenderer();
			{/if}
		{/if}
		var latlng = new google.maps.LatLng(__latitude,__lungidute);
		var opt = 
		{ldelim}
			center:latlng,
			zoom:__zoom,
			mapTypeId: google.maps.MapTypeId.{$__MAPTYPE},
			disableAutoPan:false,
			navigationControl:true,
		{if $attribute.content.nav_control|eq('zoom_pain')}
			navigationControlOptions:{ldelim}style:google.maps.NavigationControlStyle.ZOOM_PAN{rdelim},
		{elseif $attribute.content.nav_control|eq('small')}
			navigationControlOptions:{ldelim}style:google.maps.NavigationControlStyle.SMALL{rdelim},
		{else}
			navigationControlOptions:{ldelim}style:google.maps.NavigationControlStyle.DEFAULT{rdelim},
		{/if}
			mapTypeControl:true,
		{if $attribute.content.style_control|eq('menu')}
			mapTypeControlOptions:{ldelim}style:google.maps.MapTypeControlStyle.DROPDOWN_MENU{rdelim}
		{else}
			mapTypeControlOptions:{ldelim}style:google.maps.MapTypeControlStyle.HORIZONTAL_BAR{rdelim}
		{/if}
		{rdelim};
	
		var map = new google.maps.Map(document.getElementById("map"),opt);

		{if $__ENABLE_DIRECTION}
			{if $__START_FORM_HERE|count_chars()|gt(0)}
			directionsDisplay.setMap(map);
			directionsDisplay.setPanel(document.getElementById("panel"));
			{/if}
		{/if}

		var marker= new google.maps.Marker({ldelim}
			position: new google.maps.LatLng(__latitude,__lungidute),
			clickable: true,
			map: map,
			zIndex: 1000
		{rdelim});

		var infiwindow = new google.maps.InfoWindow({ldelim} content: {$__TEXT} {rdelim});

		{if $__SHOW|eq('click')}
			google.maps.event.addListener(marker, 'click', function(){ldelim}
				infiwindow.open(map,marker);
			{rdelim});
		{else}
			google.maps.event.addListener(marker,'mouseover',function(){ldelim}
				infiwindow.open(map,marker);
			{rdelim});
	
			google.maps.event.addListener(marker,'mouseout',function(){ldelim}
				infiwindow.close(map,marker);
			{rdelim});
		{/if}
	{rdelim}

	{if $__ENABLE_DIRECTION}
	function calcRoute() 
	{ldelim}
		{if $__START_FORM_HERE|count_chars()|gt(0)}
		var partenza = "{$__START_FORM_HERE}";
		var arrivo = new google.maps.LatLng(__latitude,__lungidute);
		var request =
		{ldelim}
			origin:partenza,
			destination:arrivo,
			{if $__UNITY_SISTEM|ne('METRIC')}
				unitSystem:google.maps.DirectionsUnitSystem.IMPERIAL,
			{else}
				unitSystem:google.maps.DirectionsUnitSystem.METRIC,
			{/if}
			travelMode:google.maps.DirectionsTravelMode.{$attribute.content.directions_travel_mode}
		{rdelim};
		directionsService.route(request, function(response, status) 
						{ldelim}
							if (status == google.maps.DirectionsStatus.OK)
							{ldelim}
								directionsDisplay.setDirections(response);
							{rdelim}
						{rdelim}
		);
		{/if}
	{rdelim}
	{/if}
</script>

<style type"text/css">
	#map{ldelim}
		width:{$__WIDTH}px;
		height:{$__HEIGHT}px;
	{rdelim}
</style>
<div id="map"></div>

{if $__START_FORM_HERE|count_chars()|gt(0)}
	{if $__default_googlemapv3_text['enable_information']|eq('true')}
		{$__TEXT|trim("'")}
		{if $__default_googlemapv3_text['enable_information_gps']|eq('true')}
		<p>
			Coordinate GPS: Lat. {$__LATITUDE|extract_left( 8 )} Long. {$__LONGITUDE|extract_left( 8 )}
		</p>
		{/if}
	{/if}
{/if}
{if $__ENABLE_DIRECTION}
<div id="directions_start">
	<form action="" method="post">
		<label for="start_form_here"><strong>{$__LABEL_START|i18n("design/googlemapsv3")}</strong>{if $__EXAMPLE|count_chars|gt(0)}{$__EXAMPLE}{/if}</label>
		<input type="text" id="start_form_here" value="" name="start_form_here">
		<input type="submit" id="submit_start" name="send_date" value="{$__BUTTON_SEND|i18n("design/googlemapsv3")}">
	</form>
</div>
<div id="panel"></div>
{/if}
<script type="text/javascript">
	function init() 
	{ldelim}
		if (arguments.callee.done) return;
		arguments.callee.done = true;
		if (_timer) 
		{ldelim}
			clearInterval(_timer);
			_timer = null;
		{rdelim}
		initialize();
	{rdelim};
	
	/* for Mozilla */
	if (document.addEventListener) 
	{ldelim}
		document.addEventListener("DOMContentLoaded", init, false);
	{rdelim}
	
	/* for Internet Explorer */
	/*@cc_on @*/
	/*@if (@_win32)
		document.write("<script id=__ie_onload defer src=javascript:void(0)><\/script>");
		var script = document.getElementById("__ie_onload");
		script.onreadystatechange = function() 
		{ldelim}
			if (this.readyState == "complete") 
			{ldelim}
				init();
			{rdelim}
		{rdelim};
	/*@end @*/
	
	/* for Safari */
	if (/WebKit/i.test(navigator.userAgent)) {ldelim} // sniff
		var _timer = setInterval(function()
		{ldelim}
			if (/loaded|complete/.test(document.readyState)) 
			{ldelim}
				init();
			{rdelim}
		{rdelim}, 10);
	{rdelim}
	
	window.onload = init;
</script>