<?php#?ini charset="utf-8"?

[Googlemapv3Settings]
mapAdminDimension[]
mapAdminDimension[width]=350
mapAdminDimension[height]=300

#Default value
mapFrontEndDimension[]
mapFrontEndDimension[width]=500
mapFrontEndDimension[height]=500

#Default position, zoom for google map
mapPosition[]
mapPosition[latitude]=46.13904704779097
mapPosition[longitude]=11.10417366027832
mapPosition[zoom]=13

textForntEnd[]
#Examle for front-end
textForntEnd[example]=( Es: corso Buenos Aires, Milano, MI, Italy )
#Label that yoy see in font-end site when you select 'text'
#
textForntEnd[label]=Place to start
#Text of button for send your request
#
textForntEnd[button]=Send information

#Enable Information Under Maps
#
textForntEnd[enable_information]=true
#Enable GPS Information
#
textForntEnd[enable_information_gps]=true


[AdminInterface]

interfaceComponent[]

#Switch to "true" value if you want have choice to select maker show with click or mouse over.
#If value is "click" or "over", you don't have choice and the default value is the value you have assigned
#value:
#	click
#	over
#	true
interfaceComponent[selectShowMarker]=click

#Switch to "true" for have select in back-end or select default value
#value:
#	small
#	zoom_pain
#	default
#	true
interfaceComponent[selectNavigationControl]=true


#Switch to "true" for have select in back-end or select default value
#value:
#	bar
#	menu
#	true
interfaceComponent[selectControlStyle]=true

#Switch to "true" for have select in back-end or select default value
#value:
#	HYBRID
#	ROADMAP
#	SATELLITE
#	TERRAIN
#	true
interfaceComponent[selectMapType]=true

#Enable choice in back-end for directions utility
#value:
#	true	-	Enalbe choice in admin interface
#	false	-	Disable it
interfaceComponent[directions]=true

#Example of arrive's text for admin interface
#
interfaceComponent[directions_arrive_example_text_admin]=( Es: corso Buenos Aires, Milano, MI, Italy )

#Defaul Unity System
#value:
#	METRIC
#	IMPERIAL
interfaceComponent[directions_unity_system]=METRIC

#Defaul Travel Mode
#value:
#	DRIVING	
#	WALKING
interfaceComponent[directions_travel_mode]=DRIVING

?>