<?php
/*!
\class   GoogleMapV3Type googlemapv3type.php
\version 1.2
\date    May 2010
\author  Pierandrea Della Putta
*/

include_once( "kernel/classes/ezdatatype.php" );

// debug
include_once( "lib/ezutils/classes/ezdebug.php" );

define( "EZ_DATATYPESTRING_GOOGLE_V3", "googlemapv3" );


class GoogleMapV3Type extends eZDataType
{
//  	const DATA_TYPE_STRING = 'googlemapv3';

	/**
	* Class's constructor 
	*/
	function GoogleMapV3Type()
	{
		//$this->eZDataType( self::DATA_TYPE_STRING, "Google Maps V3" );
		$this->eZDataType( EZ_DATATYPESTRING_GOOGLE_V3, "Google Maps V3" );
	}

	/**
	* Validates input on content object level
	* \return EZ_INPUT_VALIDATOR_STATE_ACCEPTED or EZ_INPUT_VALIDATOR_STATE_INVALID if the values are accepted or not
	*/
	function validateObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
	{
		$debug = true;
		if ($http->hasPostVariable( $base . '_googlemapv3_latitude_' . $contentObjectAttribute->attribute( 'id' ) ) && 
		    $http->hasPostVariable( $base . '_googlemapv3_longitude_' . $contentObjectAttribute->attribute( "id" ) ) )
		{
			$__latitude = $http->postVariable( $base . '_googlemapv3_latitude_' . $contentObjectAttribute->attribute( 'id' ) );
			eZDebug::writeNotice("Latidude: " . $pathpoints);
			$__longitude = $http->postVariable( $base . '_googlemapv3_longitude_' . $contentObjectAttribute->attribute( 'id' ) );
			eZDebug::writeNotice("Longidue: " . $zoomlevel);
			$__zoom = $http->postVariable( $base . '_googlemapv3_zoom_' . $contentObjectAttribute->attribute( 'id' ) );
			eZDebug::writeNotice("Zoom: " . $zoomlevel);

 			$__fe_width = $http->postVariable( $base . '_googlemapv3_width_' . $contentObjectAttribute->attribute( 'id' ) );
 			$__fe_height = $http->postVariable( $base . '_googlemapv3_height_' . $contentObjectAttribute->attribute( 'id' ) );
			
			if (!is_numeric($__fe_width) or $__fe_width <= 0) 
			{
				$contentObjectAttribute->setValidationError("Width value must be numeric and great 0");
				return eZInputValidator::STATE_INVALID;
			}

			if (!is_numeric($__fe_height) or $__fe_height <= 0) 
			{
				$contentObjectAttribute->setValidationError("Height value must be numeric and great 0");
				return eZInputValidator::STATE_INVALID;
			}

			if ( $__zoom < 0 or $__zoom > 19 or !is_numeric($__zoom) )
			{
				$contentObjectAttribute->setValidationError("Zoom Level is not in the correct range (0 - 19). Value of zoom is: [ $__zoom ]");
				return eZInputValidator::STATE_INVALID;
			}

			return eZInputValidator::STATE_ACCEPTED;
		}
		$contentObjectAttribute->setValidationError("You didn't fill in all the fields.");
		return eZInputValidator::STATE_INVALID;
	}

	/**
	* Fetches all variables from the object
	* \return true if fetching of class attributes are successfull, false if not
	*/
	function fetchObjectAttributeHTTPInput( $http, $base, $contentObjectAttribute )
	{
		if ($http->hasPostVariable( $base . '_googlemapv3_latitude_' . $contentObjectAttribute->attribute( 'id' ) ) && 
		    $http->hasPostVariable( $base . '_googlemapv3_longitude_' . $contentObjectAttribute->attribute( "id" ) ) )
		{
			$__latitude = $http->postVariable( $base . '_googlemapv3_latitude_' . $contentObjectAttribute->attribute( 'id' ) );
			$__longitude = $http->postVariable( $base . '_googlemapv3_longitude_' . $contentObjectAttribute->attribute( 'id' ) );
			$__zoom = $http->postVariable( $base . '_googlemapv3_zoom_' . $contentObjectAttribute->attribute( 'id' ) );
			$__text_marker = $http->postVariable( $base . '_googlemapv3_text_marker_' . $contentObjectAttribute->attribute( 'id' ) );

			$__SUM_STRING = "";
			for($i = 0; $i < strlen($__text_marker);$i++)
			{
				if( (ord($__text_marker{$i}) != 10 and ord($__text_marker{$i}) != 13))
				{
					$__SUM_STRING .= $__text_marker{$i};
				}
				elseif(ord($__text_marker{$i}) == 13)
				{
					$__SUM_STRING .= "<br />";
				}
			}

			$__text_marker = $__SUM_STRING;
 			$__show_marker = $http->postVariable( $base . '_googlemapv3_show_marker_' . $contentObjectAttribute->attribute( 'id' ) );

 			$__fe_width = $http->postVariable( $base . '_googlemapv3_width_' . $contentObjectAttribute->attribute( 'id' ) );
 			$__fe_height = $http->postVariable( $base . '_googlemapv3_height_' . $contentObjectAttribute->attribute( 'id' ) );

 			$__nav_control = $http->postVariable( $base . '_googlemapv3_navigation_control_' . $contentObjectAttribute->attribute( 'id' ) );
 			$__style = $http->postVariable( $base . '_googlemapv3_control_style_' . $contentObjectAttribute->attribute( 'id' ) );
 			$__maptype = $http->postVariable( $base . '_googlemapv3_map_type_' . $contentObjectAttribute->attribute( 'id' ) );

			$__enable_directions = $http->postVariable( $base . '_googlemapv3_directions_start_from_' . $contentObjectAttribute->attribute( 'id' ) );
			$__directions_travel_mode = $http->postVariable( $base . '_googlemapv3_directions_travel_mode_' . $contentObjectAttribute->attribute( 'id' ) );

			$__output_language = $http->postVariable( $base . '_googlemapv3_output_language_directions_' . $contentObjectAttribute->attribute( 'id' ) );
			$__unity_system = $http->postVariable( $base . '_googlemapv3_directions_unity_system_' . $contentObjectAttribute->attribute( 'id' ) );

			$__googlemapv3Data = serialize(array('latitude' => $__latitude,
							'longitude' => $__longitude,
							'zoom' => $__zoom,
							'text'=>$__text_marker,
							'height'=>$__fe_height,
							'width'=>$__fe_width,
							'style_control'=>$__style,
							'nav_control'=>$__nav_control,
							'map_type'=>$__maptype,
							'enable_directions'=>$__enable_directions,
							'directions_travel_mode'=>$__directions_travel_mode,
							'output_language'=>$__output_language,
							'unity_system'=>$__unity_system,
							'show'=>$__show_marker
						)
			);

			$contentObjectAttribute->setAttribute( "data_text" , $__googlemapv3Data);
			return true;
		}
		return false;
	}

	/**
	* Returns the content.
	*/
	function objectAttributeContent( $contentObjectAttribute )
	{
		$__array_googlemapv3Data = unserialize($contentObjectAttribute->attribute( "data_text" ));

		$result = array('latitude' => $__array_googlemapv3Data['latitude'],
				'longitude' => $__array_googlemapv3Data['longitude'],
				'zoom'=>$__array_googlemapv3Data['zoom'],
				'text'=>$__array_googlemapv3Data['text'],
				'height'=>$__array_googlemapv3Data['height'],
				'width'=>$__array_googlemapv3Data['width'],
				'style_control'=>$__array_googlemapv3Data['style_control'],
				'nav_control'=>$__array_googlemapv3Data['nav_control'],
				'map_type'=>$__array_googlemapv3Data['map_type'],
				'enable_directions'=>$__array_googlemapv3Data['enable_directions'],
				'directions_travel_mode'=>$__array_googlemapv3Data['directions_travel_mode'],
				'output_language'=>$__array_googlemapv3Data['output_language'],
				'unity_system'=>$__array_googlemapv3Data['unity_system'],
				'show'=>$__array_googlemapv3Data['show']);
		return $result;
	}

	/**
	* Returns the meta data used for storing search indeces.
	*/
	function metaData( $contentObjectAttribute )
	{
		return $contentObjectAttribute->attribute( "data_text" );
	}

	/**
	* Returns the value as it will be shown if this attribute is used in the object name pattern.
	*/
	function title( $contentObjectAttribute, $name = null )
	{
		return "Google Maps V3 id: ".$contentObjectAttribute->attribute( 'id' );
	}

	/**
	* Return true if the datatype can be indexed
	*/
	function isIndexable()
	{
		return true;
	}
}

/*eZDataType::register( GoogleMapV3Type::DATA_TYPE_STRING, "googlemapv3type" );*/
eZDataType::register( EZ_DATATYPESTRING_GOOGLE_V3, "googlemapv3type" );
?>
