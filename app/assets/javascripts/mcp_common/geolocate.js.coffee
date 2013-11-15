
# Grab the geolocation coordinates
@showPosition = (pos) ->
  $('#location_attributes_latitude').val(pos.coords.latitude)
  $('#location_attributes_longitude').val(pos.coords.longitude)
  $('#edit_location').submit()
  #alert "Latitude: " + pos.coords.latitude + "\nLongitude: " + pos.coords.longitude
  #alert $("#subscription_id").val()
window.onload = ->
  if navigator.geolocation # true if the browser supports geo-location
    #alert 'Location Supported'
    navigator.geolocation.getCurrentPosition showPosition
  else
    #alert 'Location NOT Supported'


