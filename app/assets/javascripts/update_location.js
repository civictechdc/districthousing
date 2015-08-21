$(document).ready(function(e) {

$(".edit_housing_form").submit(function(e) {

  e.preventDefault();
  var data = $(".edit_housing_form").serializeArray();
  // grabs updated location
  var updated_location = data[4].value;


  // grabs original housing_form info in
  var housing_data = JSON.parse(($("#edit_button")).attr("data"));
  var original_location = housing_data['location'];
  console.log(data);
  console.log(JSON.parse(JSON.stringify(data)));
  console.log(($("#edit_button")).attr("data"));
  console.log((housing_data));

  if (updated_location == original_location) {
    // alert('same');
  }


});

});


