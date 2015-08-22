# Markers are global
# One marker per map, can be changed into array

marker = ''

addMarker = (coordinates,name,map) ->
  marker = L.marker([coordinates[0], coordinates[1]]).addTo(map)
  map.setView([coordinates[0], coordinates[1]], 15)


popUp = (name,location) ->
  popup = L.popup(minWidth: 100).setContent("<b>"+name+"</b><hr style='margin:5px 0px;border-top: 1px solid black;' />"+location)
  marker.bindPopup(popup).openPopup()

$ ->
  $('.housing-location-table').DataTable({
    dom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    pagingType: "simple_numbers",
    language: {
      search: "",
      searchPlaceholder: "Search"
    },
    "columnDefs": [
      {
        "orderable": false,
        "targets": [2, 6, 7, 8]
      },
      {
        "searchable": false,
        "targets": [2, 3, 4, 5, 6, 7, 8]
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
        "targets": [2, 3, 4, 5, 6, 7]
      }
    ],
    "dom": '<"wrapper"ftpr>'
  })

  $('.application').DataTable({
    dom: "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    pagingType: "simple_numbers",
    language: {
      search: "",
      searchPlaceholder: "Search"
    },
    "columnDefs": [
      {
        "orderable": false,
        "targets": [2, 3, 4]
      },
      {
        "searchable": false,
        "targets": [2, 3, 4]
      }
    ],
    "dom": '<"wrapper"ftpr>'
  })

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
    housing_data = JSON.parse(button.attr('housing-data'))
    $('#housing-location-modal .modal-title').text(housing_data.name)
    name = housing_data.name
    address = housing_data.location
    coordinates = [housing_data.lat, housing_data.long]

    addMarker coordinates,name,map
    $('#housing-location-modal').modal()
    popUp name,address
  )
