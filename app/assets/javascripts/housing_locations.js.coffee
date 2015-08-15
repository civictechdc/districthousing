# Markers are global
# One marker per map, can be changed into array

marker = ''

addMarker = (coordinates,map) ->

  marker = L.marker([coordinates[0], coordinates[1]])
  marker.addTo(map);
  map.setView([coordinates[0], coordinates[1]], 15)
  $('#housing-location-modal').modal()

# Google's Geocoder
# https://developers.google.com/maps/documentation/geocoding/intro
# limitations
# 2500 requests per 24 hour period.
# 5 requests per second.

displayHousingLocationMap = (address,map) ->
  geocoder = new (google.maps.Geocoder)
  coordinates = []
  geocoder.geocode {
    'address': address
    'region': 'us'
  }, (results, status) ->
    if status == google.maps.GeocoderStatus.OK
      coordinates[0] = results[0].geometry.location.lat()
      coordinates[1] = results[0].geometry.location.lng()
      addMarker coordinates,map
    else
      result = 'Unable to find address: ' + status
      alert('Address not found.')
    return



$ ->

  $('.housing-location-table').DataTable({
    dom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    pagingType: "simple_numbers",
    "columnDefs": [
      {
        "orderable": false,
        "targets": [6,7,8,9]
      },
      {
        "searchable": false,
        "targets": [2,3,4,5,6,7,8,9]
      }
    ],
    "dom": '<"wrapper"ftpr>'
  })

  $('.housing-location-table-no-edit').DataTable({
    dom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    pagingType: "simple_numbers",
    "columnDefs": [
      {
        "orderable": false,
        "targets": [6,7]
      },
      {
        "searchable": false,
        "targets": [2,3,4,5,6,7]
      }
    ],
    "dom": '<"wrapper"ftpr>'
  })

  $('div.dataTables_filter input').focus()

# Map related events and initialization
$ ->
  # checking if the map area and buttons exists
  return if $('#housing-location-map').length == 0
  buttons = $('button.housing-location-show-map')
  return if buttons.length == 0


  #initializing map

  L.Icon.Default.imagePath = '/assets'
  map = L.map('housing-location-map').setView([38.9, -77.0], 10)
  marker = L.marker([38.9, -77.0]).addTo(map)
  url = 'http://{s}.tile.osm.org/{z}/{x}/{y}.png'
  L.tileLayer(url, {
    attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }).addTo(map)

  # initializing modal area
  $('#housing-location-modal').on('shown.bs.modal', () ->
    map.invalidateSize()
  )

  #setting up the buttons to show the map
  buttons.click((event) ->
    map.removeLayer marker
    button = $(event.target)
    # on firefox the event is triggered on the button, but on chrome, it may be
    # triggered on the icon's span
    while (!button.is('button'))
      button = button.parent();
    housing_data = JSON.parse(button.attr('housing-data'))
    $('#housing-location-modal .modal-title').text(housing_data.name)

    location = housing_data.location
    displayHousingLocationMap location,map
  )
