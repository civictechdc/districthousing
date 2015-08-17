# Markers are global
# One marker per map, can be changed into array

marker = ''

updateCoordinates = (coordinates,id,housing_data) ->
  # id is unpermitted parameter in housing_data json
  delete housing_data.id
  housing_data.lat = coordinates[0]
  housing_data.long = coordinates[1]

  # TODO AJAX refresh list of housing locations
  $.ajax
    type: 'PATCH'
    url: '/housing_forms/' + id
    dataType: "json"
    data: {
    'name': housing_data.name,
    'housing_form': housing_data
    }
    success: (data) ->
      console.log('successfully updated coordinates')
    error: (data) ->
      console.log('failed updating coordinates')

addMarker = (coordinates,name,map) ->
  marker = L.marker([coordinates[0], coordinates[1]]).addTo(map)
  map.setView([coordinates[0], coordinates[1]], 15)


popUp = (name,location) ->
  popup = L.popup(minWidth: 100).setContent("<b>"+name+"</b><hr style='margin:5px 0px;border-top: 1px solid black;' />"+location)
  marker.bindPopup(popup).openPopup()

# Google's Geocoder

displayHousingLocationMap = (address,name,map,id,housing_data) ->
  geocoder = new (google.maps.Geocoder)
  coordinates = []
  geocoder.geocode {
    'address': address
    'region': 'us'
  }, (results, status) ->
    if status == google.maps.GeocoderStatus.OK
      coordinates[0] = results[0].geometry.location.lat()
      coordinates[1] = results[0].geometry.location.lng()
      # update housing form coordinates
      updateCoordinates coordinates,id,housing_data

      addMarker coordinates,name,map
      $('#housing-location-modal').modal()
      popUp name,address
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
    if marker
      map.removeLayer marker

    button = $(event.target)
    # on firefox the event is triggered on the button, but on chrome, it may be
    # triggered on the icon's span
    while (!button.is('button'))
      button = button.parent();

    # parse housing data for json

    housing_data = JSON.parse(button.attr('housing-data'))
    id = housing_data.id
    name = housing_data.name
    location = housing_data.location
    $('#housing-location-modal .modal-title').text(name)

    # if housing data has long and lat

    if (housing_data.long != null && housing_data.lat != null)
      console.log('calling from database')

      coordinates = []
      coordinates[0] = housing_data.lat
      coordinates[1] = housing_data.long

      # display map using coordinates
      addMarker coordinates,name,map
      $('#housing-location-modal').modal()
      popUp name,location

    # proceed with geocoding

    else
      console.log('calling google geocode')

      displayHousingLocationMap location,name,map,id,housing_data
  )
