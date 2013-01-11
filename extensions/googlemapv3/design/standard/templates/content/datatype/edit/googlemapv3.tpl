{def $__dimension_googlemapv3 = ezini( 'Googlemapv3Settings', 'mapAdminDimension', 'googlemapv3.ini' )}
{def $__default_googlemapv3 = ezini( 'Googlemapv3Settings', 'mapPosition', 'googlemapv3.ini' )}
{def $__click_choice = ezini( 'AdminInterface', 'interfaceComponent', 'googlemapv3.ini' )}
<div class="block">
	<style type="text/css">
		#map_canvas{ldelim}
			width: {$__dimension_googlemapv3['width']}px;
			height: {$__dimension_googlemapv3['height']}px;
			border: 1px solid gray;
			margin-top:6px;
		{rdelim}
	</style>
	{def $__CLICK = ''}
	{def $__OVER = ''}
	{if $attribute.content.show|eq('click')}
		{set $__CLICK = 'checked="checked"'}
	{elseif $attribute.content.show|eq('over')}
		{set $__OVER = 'checked="checked"'}
	{else}
		{set $__CLICK = 'checked="checked"'}
	{/if}

	{def $__LONGITUDE=''}
	{def $__LATITUDE=''}
	{def $__ZOOM=''}
	
	{if $attribute.content.latitude|is_numeric()}
		{set $__LONGITUDE = $attribute.content.latitude}
	{else}
		{set $__LONGITUDE = $__default_googlemapv3['latitude']}
	{/if}

	{if $attribute.content.longitude|is_numeric()}
		{set $__LATITUDE = $attribute.content.longitude}
	{else}
		{set $__LATITUDE = $__default_googlemapv3['longitude']}
	{/if}

	{if $attribute.content.zoom|is_numeric()}
		{set $__ZOOM = $attribute.content.zoom}
	{else}
		{set $__ZOOM = $__default_googlemapv3['zoom']}
	{/if}

	{def $__MENU = ''}
	{def $__BAR = ''}
	{def $__SMALL = ''}
	{def $__ZOOM_PAIN= ''}
	{def $__DEFAUL = ''}
	{def $__HYBRID = ''}
	{def $__ROADMAP = ''}
	{def $__SATELLITE = ''}
	{def $__TERRAIN = ''}
	{def $__START_FROM_YES = ''}
	{def $__START_FROM_NO = 'checked="checked"'}
	{def $__DRIVING = ''}
	{def $__WALKING = ''}
	{def $__IMPERIAL = ''}
	{def $__METRIC = ''}
	{def $__LANG = $attribute.content.output_language}

	{def $__EXAMPLE_ADMIN = $__click_choice['directions_arrive_example_text_admin']}

	{if $attribute.content.directions_unity_system|eq('METRIC')}
		{set $__METRIC = 'checked="checked"'}
	{elseif $attribute.content.directions_unity_system|eq('IMPERIAL')}
		{set $__IMPERIAL = 'checked="checked"'}
	{else}
		{if $__click_choice['directions_unity_system']|eq('METRIC')}
			{set $__METRIC= 'checked="checked"'}
		{elseif $__click_choice['directions_unity_system']|eq('IMPERIAL')}
			{set $__IMPERIAL = 'checked="checked"'}
		{else}
			{set $__METRIC= 'checked="checked"'}
		{/if}
	{/if}

	{if $attribute.content.directions_travel_mode|eq('WALKING')}
		{set $__WALKING = 'checked="checked"'}
	{elseif $attribute.content.directions_travel_mode|eq('DRIVING')}
		{set $__DRIVING = 'checked="checked"'}
	{else}
		{if $__click_choice['directions_travel_mode']|eq('WALKING')}
			{set $__WALKING = 'checked="checked"'}
		{elseif $__click_choice['directions_travel_mode']|eq('DRIVING')}
			{set $__DRIVING = 'checked="checked"'}
		{else}
			{set $__DRIVING = 'checked="checked"'}
		{/if}
	{/if}

	{if $attribute.content.enable_directions|eq('yes')}
		{set $__START_FROM_YES = 'checked="checked"'}
		{set $__START_FROM_NO = ''}
	{/if}

	{if $attribute.content.style_control|eq('menu')}
		{set $__MENU = 'checked="checked"'}
	{elseif $attribute.content.style_control|eq('bar')}
		{set $__BAR = 'checked="checked"'}
	{else}
		{set $__BAR = 'checked="checked"'}
	{/if}

	{if $attribute.content.nav_control|eq('small')}
		{set $__SMALL = 'checked="checked"'}
	{elseif $attribute.content.nav_control|eq('zoom_pain')}
		{set $__ZOOM_PAIN= 'checked="checked"'}
	{elseif $attribute.content.nav_control|eq('default')}
		{set $__DEFAUL = 'checked="checked"'}
	{else}
		{set $__DEFAUL = 'checked="checked"'}
	{/if}

	{if $attribute.content.map_type|eq('HYBRID')}
		{set $__HYBRID = 'checked="checked"'}
	{elseif $attribute.content.map_type|eq('ROADMAP')}
		{set $__ROADMAP= 'checked="checked"'}
	{elseif $attribute.content.map_type|eq('SATELLITE')}
		{set $__SATELLITE = 'checked="checked"'}
	{elseif $attribute.content.map_type|eq('TERRAIN')}
		{set $__TERRAIN = 'checked="checked"'}
	{else}
		{set $__HYBRID = 'checked="checked"'}
	{/if}

	<fieldset>
		<table>
			<tbody>
				<tr valign="top">
					<td>
						<div  id="map_canvas" style="position: relative; background-color: rgb(229, 227, 223);"></div>
					</td>
					<td style="padding-left: 20px;">
						<table>
							<tbody>
                                                                <tr>
                                                                    <td></td>
									<td>
                                                                            <strong>{'Click on the map to add an address or insert it manually'|i18n("design/googlemapsv3")}</strong>
                                                                        </td>
								</tr>
								<tr>
									<td align="right">{'Current Address'|i18n("design/googlemapsv3")}:</td>
									<td>
										<input type="text" name="ContentObjectAttribute_googlemapv3_currentaddress_{$attribute.id}"  id="txtCAddress" value="" size="90" readonly="readonly" style="background-color:#EEEEEE;" />
									</td>
								</tr>
								<tr>
									<td align="right">{'Insert address'|i18n("design/googlemapsv3")}:</td>
									<td>
										<input type="text" name="ContentObjectAttribute_googlemapv3_address_{$attribute.id}"  id="txtAddress" value="" size="90" onchange="onChange(this)" />
									</td>
								</tr>
								<tr>
									<td align="right">{'Latitude'|i18n("design/googlemapsv3")}:</td>
									<td>
										<input type="text" name="ContentObjectAttribute_googlemapv3_latitude_{$attribute.id}"  id="txtLatitude" value="{$__LONGITUDE}" size="90" readonly="readonly" style="background-color:#EEEEEE;" />
									</td>
								</tr>
								<tr>
									<td align="right">{'Longitude'|i18n("design/googlemapsv3")}:</td>
									<td>
										<input type="text" name="ContentObjectAttribute_googlemapv3_longitude_{$attribute.id}" id="txtLongitude" value="{$__LATITUDE}" size="90" readonly="readonly" style="background-color:#EEEEEE;"/>
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right">{'Zoom'|i18n("design/googlemapsv3")}:</td>
									<td>
										<input type="text" name="ContentObjectAttribute_googlemapv3_zoom_{$attribute.id}" id="txtZoom" value="{$__ZOOM}" size="2"  />
									</td>
								</tr>
								{*<tr>
									<td align="right">{'Text Marker'|i18n("design/googlemapsv3")}:</td>
									<td>
										<textarea rows="5" cols="60" id="txtText" name="ContentObjectAttribute_googlemapv3_text_marker_{$attribute.id}">{$attribute.content.text}</textarea>
									</td>
								</tr>*}
								{if $__click_choice['selectShowMarker']|eq('true')}
								<tr style="display:none;">
									<td align="right">{'Marker comportament'|i18n("design/googlemapsv3")}:</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_show_marker_{$attribute.id}" value="click" {$__CLICK} />{'Click on marker to show message'|i18n("design/googlemapsv3")}
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_show_marker_{$attribute.id}" value="over" {$__OVER} />{'Over on mouse to show message'|i18n("design/googlemapsv3")}
									</td>
								</tr>
								{else}
									<input type="hidden" name="ContentObjectAttribute_googlemapv3_show_marker_{$attribute.id}" value="{$__click_choice['selectShowMarker']}">
								{/if}
								<tr style="display:none;">
									<td align="right">{'Front-end map dimension'|i18n("design/googlemapsv3")}:</td>
								</tr>
								<tr style="display:none;">
									<td align="right">{'Width'|i18n("design/googlemapsv3")}:</td>
									<td>
										<input type="text" name="ContentObjectAttribute_googlemapv3_width_{$attribute.id}" id="txtZoom" value="500" size="4"  />
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right">{'Height'|i18n("design/googlemapsv3")}:</td>
									<td>
										<input type="text" name="ContentObjectAttribute_googlemapv3_height_{$attribute.id}" id="txtZoom" value="500" size="4"  />
									</td>
								</tr>
								{if $__click_choice['selectNavigationControl']|eq('true')}
								<tr style="display:none;">
									<td align="right">{'Front-end Navigation Control'|i18n("design/googlemapsv3")}: {$__SMALL}</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_navigation_control_{$attribute.id}" value="small" {$__SMALL} />SMALL
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_navigation_control_{$attribute.id}" value="zoom_pain" {$__ZOOM_PAIN} />ZOOM_PAN
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_navigation_control_{$attribute.id}" value="default" {$__DEFAUL} />DEFAULT
									</td>
								</tr>
								{else}
									<input type="hidden" name="ContentObjectAttribute_googlemapv3_navigation_control_{$attribute.id}" value="{$__click_choice['selectNavigationControl']}">
								{/if}
								{if $__click_choice['selectControlStyle']|eq('true')}
								<tr style="display:none;">
									<td align="right">{'Front-end Control Style'|i18n("design/googlemapsv3")}:</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_control_style_{$attribute.id}" value="bar" {$__BAR} />HORIZONTAL_BAR
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_control_style_{$attribute.id}" value="menu" {$__MENU} />DROPDOWN_MENU
									</td>
								</tr>
								{else}
									<input type="hidden" name="ContentObjectAttribute_googlemapv3_navigation_control_{$attribute.id}" value="{$__click_choice['selectControlStyle']}">
								{/if}
								{if $__click_choice['selectMapType']|eq('true')}
								<tr style="display:none;">
									<td align="right">{'Default Map Type'|i18n("design/googlemapsv3")}:</td>
								</tr>

								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_map_type_{$attribute.id}" value="HYBRID" {$__HYBRID} />HYBRID
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_map_type_{$attribute.id}" value="ROADMAP" {$__ROADMAP} />ROADMAP
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_map_type_{$attribute.id}" value="SATELLITE" {$__SATELLITE} />SATELLITE
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_map_type_{$attribute.id}" value="TERRAIN" {$__TERRAIN} />TERRAIN
									</td>
								</tr>
								{else}
									<input type="hidden" name="ContentObjectAttribute_googlemapv3_map_type_{$attribute.id}" value="{$__click_choice['selectMapType']}">
								{/if}
								{if $__click_choice['directions']|eq('true')}
								<tr style="display:none;">
									<td align="right">{'Enable google maps Direction system'|i18n("design/googlemapsv3")}:</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_directions_start_from_{$attribute.id}" value="yes" {$__START_FROM_YES} />YES
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_directions_start_from_{$attribute.id}" value="no" {$__START_FROM_NO} />NO
									</td>
								</tr>

								<tr style="display:none;">
									<td align="right">{'Unit Systems'|i18n("design/googlemapsv3")}:</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_directions_unity_system_{$attribute.id}" value="METRIC" {$__METRIC} />METRIC
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_directions_unity_system_{$attribute.id}" value="IMPERIAL" {$__IMPERIAL} />IMPERIAL
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right">{'Output language directions'|i18n("design/googlemapsv3")}:</td>
									<td>
{*										<input type="text" name="ContentObjectAttribute_googlemapv3_output_language_directions_{$attribute.id}" value="{$__LANG}" size="2" maxlength="2"/>*}
										<select name="ContentObjectAttribute_googlemapv3_output_language_directions_{$attribute.id}">
											<option value="ar" {if $__LANG|eq('ar')}selected{/if}>ARABIC</option>
											<option value="eu" {if $__LANG|eq('eu')}selected{/if}>BASQUE</option>
											<option value="bg" {if $__LANG|eq('bg')}selected{/if}>BULGARIAN</option>
											<option value="bn" {if $__LANG|eq('bn')}selected{/if}>BENGALI</option>
											<option value="ca" {if $__LANG|eq('ca')}selected{/if}>CATALAN</option>
											<option value="cs" {if $__LANG|eq('cs')}selected{/if}>CZECH</option>
											<option value="da" {if $__LANG|eq('da')}selected{/if}>DANISH</option>
											<option value="de" {if $__LANG|eq('de')}selected{/if}>GERMAN</option>
											<option value="el" {if $__LANG|eq('el')}selected{/if}>GREEK</option>
											<option value="en" {if $__LANG|eq('en')}selected{/if}>ENGLISH</option>
											<option value="en-AU" {if $__LANG|eq('en-AU')}selected{/if}>ENGLISH (AUSTRALIAN)</option>
											<option value="en-GB" {if $__LANG|eq('en-GB')}selected{/if}>ENGLISH (GREAT BRITAIN)</option>
											<option value="es" {if $__LANG|eq('es')}selected{/if}>SPANISH</option>
											<option value="eu" {if $__LANG|eq('eu')}selected{/if}>BASQUE</option>
											<option value="fa" {if $__LANG|eq('fa')}selected{/if}>FARSI</option>
											<option value="fi" {if $__LANG|eq('fi')}selected{/if}>FINNISH</option>
											<option value="fil" {if $__LANG|eq('fil')}selected{/if}>FILIPINO</option>
											<option value="fr" {if $__LANG|eq('fr')}selected{/if}>FRENCH</option>
											<option value="gl" {if $__LANG|eq('gl')}selected{/if}>GALICIAN</option>
											<option value="gu" {if $__LANG|eq('gu')}selected{/if}>GUJARATI</option>
											<option value="hi" {if $__LANG|eq('hi')}selected{/if}>HINDI</option>
											<option value="hr" {if $__LANG|eq('hr')}selected{/if}>CROATIAN</option>
											<option value="hu" {if $__LANG|eq('hu')}selected{/if}>HUNGARIAN</option>
											<option value="id" {if $__LANG|eq('id')}selected{/if}>INDONESIAN</option>
											<option value="it" {if $__LANG|eq('it')}selected{/if}>ITALIAN</option>
											<option value="iw" {if $__LANG|eq('iw')}selected{/if}>HEBREW</option>
											<option value="ja" {if $__LANG|eq('ja')}selected{/if}>JAPANESE</option>
											<option value="kn" {if $__LANG|eq('kn')}selected{/if}>KANNADA</option>
											<option value="ko" {if $__LANG|eq('ko')}selected{/if}>KOREAN</option>
											<option value="lt" {if $__LANG|eq('lt')}selected{/if}>LITHUANIAN</option>
											<option value="lv" {if $__LANG|eq('lv')}selected{/if}>LATVIAN</option>
											<option value="ml" {if $__LANG|eq('ml')}selected{/if}>MALAYALAM</option>
											<option value="mr" {if $__LANG|eq('mr')}selected{/if}>MARATHI</option>
											<option value="nl" {if $__LANG|eq('nl')}selected{/if}>DUTCH</option>
											<option value="no" {if $__LANG|eq('no')}selected{/if}>NORWEGIAN</option>
											<option value="pl" {if $__LANG|eq('pl')}selected{/if}>POLISH</option>
											<option value="pt" {if $__LANG|eq('pt')}selected{/if}>PORTUGUESE</option>
											<option value="pt-BR" {if $__LANG|eq('pt-BR')}selected{/if}>PORTUGUESE (BRAZIL)</option>
											<option value="pt-PT" {if $__LANG|eq('pt-PT')}selected{/if}>PORTUGUESE (PORTUGAL)</option>
											<option value="ro" {if $__LANG|eq('ro')}selected{/if}>ROMANIAN</option>
											<option value="ru" {if $__LANG|eq('ru')}selected{/if}>RUSSIAN</option>
											<option value="sk" {if $__LANG|eq('sk')}selected{/if}>SLOVAK</option>
											<option value="sl" {if $__LANG|eq('sl')}selected{/if}>SLOVENIAN</option>
											<option value="sr" {if $__LANG|eq('sr')}selected{/if}>SERBIAN</option>
											<option value="sv" {if $__LANG|eq('sv')}selected{/if}>SWEDISH</option>
											<option value="tl" {if $__LANG|eq('tl')}selected{/if}>TAGALOG</option>
											<option value="ta" {if $__LANG|eq('ta')}selected{/if}>TAMIL</option>
											<option value="te" {if $__LANG|eq('te')}selected{/if}>TELUGU</option>
											<option value="th" {if $__LANG|eq('th')}selected{/if}>THAI</option>
											<option value="tr" {if $__LANG|eq('tr')}selected{/if}>TURKISH</option>
											<option value="uk" {if $__LANG|eq('uk')}selected{/if}>UKRAINIAN</option>
											<option value="vi" {if $__LANG|eq('vi')}selected{/if}>VIETNAMESE</option>
											<option value="zh-CN" {if $__LANG|eq('zh-CN')}selected{/if}>CHINESE (SIMPLIFIED)</option>
											<option value="zh-TW" {if $__LANG|eq('zh-TW')}selected{/if}>CHINESE (TRADITIONAL)</option>
										</select>
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right">{'Direction travel mode'|i18n("design/googlemapsv3")}:</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_directions_travel_mode_{$attribute.id}" value="DRIVING" {$__DRIVING} />DRIVING
									</td>
								</tr>
								<tr style="display:none;">
									<td align="right"></td>
									<td>
										<input type="radio" name="ContentObjectAttribute_googlemapv3_directions_travel_mode_{$attribute.id}" value="WALKING" {$__WALKING} />WALKING
									</td>
								</tr>
								{else}
									<input type="hidden" name="ContentObjectAttribute_googlemapv3_directions_start_from_{$attribute.id}" value="no" />
								{/if}
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
			<script type="text/javascript" src={'/extension/googlemapv3/design/standard/javascript/js'|ezroot()}></script>
			<script type="text/javascript" src={'/extension/googlemapv3/design/standard/javascript/googlemapv3.js'|ezroot()}></script>
			<script type="text/javascript">
				createMap({$__LONGITUDE}, {$__LATITUDE},{$__ZOOM})
			</script>
		</table>
	</fieldset>
</div>
{undef}