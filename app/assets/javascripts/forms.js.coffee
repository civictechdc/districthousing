submitAndNext = ->
  console.log("next")
  $('#submit-direction').val("next")
  $(this).closest('form').submit()

submitAndPrevious = ->
  $('#submit-direction').val("previous")
  $(this).closest('form').submit()

$ ->
  $('.submit-next').click(submitAndNext)
  $('.submit-previous').click(submitAndPrevious)
