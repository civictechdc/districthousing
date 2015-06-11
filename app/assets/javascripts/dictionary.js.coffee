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
# Must be called on the page, or else the script misbehaves
window.dictionarySetupSidenav = ->
  sidenav = $('#pdf-guide-sidenav')
  sidenav.affix({
    offset: {
      top: -> (this.top = $('#pdf-guide-sidenav').offset().top),
      bottom: -> (this.bottom = $('img.footer-logo').outerHeight(true))
    }
  })
  # this is needed for when affix starts, it changes the width
  sidenav.width(sidenav.width())
  sidenav.on('affix.bs.affix', ->
    size = $(window).width()
    divWidth = $('body > div.container').width()
    margin = (size - divWidth) / 2
    $("#pdf-guide-sidenav").css("right",margin)
    $("#pdf-guide-sidenav").css("top", "10px")
  )
  sidenav.on('affix-top.bs.affix', ->
      $("#pdf-guide-sidenav").css("right","0")
      $("#pdf-guide-sidenav").css("top","0")
  )
