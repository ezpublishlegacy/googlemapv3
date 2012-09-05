var latlngs = new google.maps.MVCArray();
var displayPath;
var map;

var marker = new google.maps.Marker();

var tempIcon = new google.maps.MarkerImage(
  "http://labs.google.com/ridefinder/images/mm_20_green.png",
  new google.maps.Size(12,20),
  new google.maps.Size(6,20)
);

var locationIcon = new google.maps.MarkerImage(
  "http://labs.google.com/ridefinder/images/mm_20_blue.png",
  new google.maps.Size(12,20),
  new google.maps.Size(6,20)
);

var newShadow = new google.maps.MarkerImage(
  "http://labs.google.com/ridefinder/images/mm_20_shadow.png",
  new google.maps.Size(22,20),
  new google.maps.Point(13,13)
);

var geocoder = new google.maps.Geocoder();

function geocodePosition(pos) {
    geocoder.geocode({
    latLng: pos
  }, function(responses) {
    if (responses && responses.length > 0) {
      updateMarkerAddress(responses[0].formatted_address);
    } else {
      updateMarkerAddress('Cannot determine address at this location.');
    }
  });
}

function updateMarkerAddress(str) {
  document.getElementById('txtCAddress').value = str;
}

function geocodeAddress(add_string) {
    geocoder.geocode({
    'address' : add_string
  }, function(responses) {
    if (responses && responses.length > 0) {
        showMarker(responses[0].geometry.location.Xa,responses[0].geometry.location.Ya)
      updateMarkerAddress(responses[0].formatted_address);
    } else {
      updateMarkerAddress('Cannot determine address at this location.');
    }
  });
}

function onChange(element){
    geocodeAddress(element.value)
}
//----------------------------------------------------------------------
// Create the Google Map to be used
//----------------------------------------------------------------------
function createMap(default_lat, default_lon, default_zoom)
{
	var point_on_map = new google.maps.LatLng(default_lat,default_lon);
	var mapOptions = 
	{
		zoom: default_zoom,
		center: point_on_map,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	};

	map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	

        marker.setMap (map);   
        marker.setDraggable (false); 
	marker.setPosition(point_on_map);
	
        
	google.maps.event.addListener(map, "click", showTempMarker);
        
        geocodePosition(point_on_map);

        
        displayPath = new google.maps.Polyline({
		map: map,
		strokeColor: "#FF0000",
		strokeOpacity: 1.0,
		strokeWeight: 2,
		path: latlngs
	})
        
        
}

function showTempMarker(e) 
{
	marker.setPosition(e.latLng);
	
	document.getElementById('txtLatitude').value = e.latLng.lat();
	document.getElementById('txtLongitude').value = e.latLng.lng();
	
	google.maps.event.addListener(map, "click", function() {
		document.getElementById('txtLatitude').value = marker.getPosition().lat();
		document.getElementById('txtLongitude').value = marker.getPosition().lng();
                geocodePosition(marker.getPosition());	
            });

	marker.setMap(map);
        map.panTo(marker.getPosition()); 
}

function showMarker(lat,lng) 
{
    
        var newLatLng = new google.maps.LatLng(lat, lng);
	marker.setPosition(newLatLng);
	
	document.getElementById('txtLatitude').value = newLatLng.lat();
	document.getElementById('txtLongitude').value = newLatLng.lng();
	
	google.maps.event.addListener(map, "click", function() {
		document.getElementById('txtLatitude').value = marker.getPosition().lat();
		document.getElementById('txtLongitude').value = marker.getPosition().lng();
                geocodePosition(marker.getPosition());	
            });

        map.panTo(marker.getPosition()); 
}

