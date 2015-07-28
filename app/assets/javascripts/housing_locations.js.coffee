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
    button = $(event.target)
    # on firefox the event is triggered on the button, but on chrome, it may be
    # triggered on the icon's span
    while (!button.is('button'))
      button = button.parent();
    housing_data = JSON.parse(button.attr('housing-data'))
    $('#housing-location-modal .modal-title').text(housing_data.name)
    lat = housing_data.lat
    long = housing_data.long
    map.removeLayer(marker)
    marker = L.marker([lat, long]).addTo(map);
    map.setView([lat, long], 13)
    $('#housing-location-modal').modal()
  )
