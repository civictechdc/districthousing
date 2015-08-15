# getLatLong = (address) ->
#   geocoder = new (google.maps.Geocoder)
#   result = ''
#   geocoder.geocode {
#     'address': address
#     'region': 'uk'
#   }, (results, status) ->
#     if status == google.maps.GeocoderStatus.OK
#       result[lat] = results[0].geometry.location.Pa
#       result[lng] = results[0].geometry.location.Qa
#     else
#       result = 'Unable to find address: ' + status
#     storeResult result
#     return
#   return
