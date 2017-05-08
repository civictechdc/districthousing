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


# Sets up the sidenav on the dictionary.
$ ->
  sidenav = $('#pdf-guide-sidenav')
  return unless sidenav.length
  # this is needed because when affix starts, the sidenav loses its width
  sidenav.width(sidenav.width())
  # sets up positioning when affix starts and stops
  sidenav.on('affix.bs.affix', ->
    margin = $("#page-dashboard").css("padding-right")
    $("#pdf-guide-sidenav").css("right", margin)
    $("#pdf-guide-sidenav").css("position", "")
  )
  sidenav.on('affix-top.bs.affix', ->
    $("#pdf-guide-sidenav").css("right", "0")
  )
  sidenav.on('affix-bottom.bs.affix', ->
    $("#pdf-guide-sidenav").css("right", "0")
  )
  # starts bootstrap affix
  sidenav.affix({
    offset: {
      top: $('#pdf-guide-sidenav').offset().top,
      bottom: $('img.footer-logo').outerHeight(true)
    }
  })
  # starts scrollspy
  $('body').scrollspy({ target: '#pdf-guide-sidenav' })
