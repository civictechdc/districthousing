replaceResultField = (data) ->

  if data.recognized
    if data.result == ""
      data.result = "(This field would be blank)"
    $('#test_field_result')
      .html(data.result)
      .attr('class', 'text-success')
  else
    $('#test_field_result')
      .html("Unrecognized field name")
      .attr('class', 'text-muted')


doTestField = ->
  entered_text = $('#field_name_test').val()
  $.get('/dictionary/test.json', {'field_name': entered_text}, replaceResultField)

$ ->
  $('#field_name_test').on('input', doTestField)
