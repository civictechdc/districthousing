$(document).ready(function(e) {

var geocoder = new google.maps.Geocoder;
var coordinates=[];
var controlLoop = 0;

function geocode(address,updated_fields_data,id,name){
  geocoder.geocode({
    'address': address,
    'region': 'us'
  }, function(results, status) {
    var result;
    if (status === google.maps.GeocoderStatus.OK) {
      console.log('Geocoding OK!');
      coordinates[0] = results[0].geometry.location.lat();
      coordinates[1] = results[0].geometry.location.lng();

      //update fields on coordinate retrieval
      updated_fields_data['lat'] = coordinates[0];
      updated_fields_data['long'] = coordinates[1];
      patch(id,name,updated_fields_data);
    } else {
      result = 'Unable to find address: ' + status;
      alert('Address not found.');

      //if address not found, empty coordinates.
      updated_fields_data['lat'] = '';
      updated_fields_data['long'] = '';
      patch(id,name,updated_fields_data);
    }
  });
}

function patch(id,name,updated_fields_data) {
  $.ajax({
      type: 'PATCH',
      url: '/housing_forms/' + id,
      dataType: "json",
      data: {
        'name': name,
        'housing_form': updated_fields_data
      },
      success: function(data) {
        return console.log('successfully PATCHed');
      },
      error: function(data) {
        return console.log('failed PATCH');
      }
    });
  $(window.location.replace("/housing_forms/"+id));
}

$(".edit_housing_form").submit(function(e) {

  e.preventDefault();
  var raw_data = JSON.parse(JSON.stringify($(".edit_housing_form").serializeArray()));

  var updated_fields_data = raw_data.reduce(function(result, currentObject) {
    for(var key in currentObject) {
        if (currentObject.hasOwnProperty(key)) {

          var matches = currentObject['name'].match(/\[([^)]+)\]/);

          // second element in array returns
          if (matches != null) {
            result[matches[1]] = currentObject['value'];
          }
          else {
            result[currentObject['name']] = currentObject['value'];
          }
        }
    }
    return result;
}, {});
  // remove unpermitted fields
  delete updated_fields_data['utf8'];
  delete updated_fields_data['_method'];
  delete updated_fields_data['authenticity_token'];

  // console.log(updated_fields_data);

  var updated_location = updated_fields_data['location'];
  var name = updated_fields_data['name'];

  var housing_data = JSON.parse(($("#edit_button")).attr("data"));
  var original_location = housing_data['location'];
  var id = housing_data['id'];

  //if location not changed, change only name.
  if (updated_location == original_location) {
    patch(id,name,updated_fields_data);
  }
  //geocode new address
  else if (updated_location != original_location) {
    geocode(updated_location,updated_fields_data,id,name);
  }

});

});


