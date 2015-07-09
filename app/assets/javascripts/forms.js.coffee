submitAndNext = ->
  $('#submit-direction').val("next")
  $(this).closest('form').submit()

submitAndPrevious = ->
  $('#submit-direction').val("previous")
  $(this).closest('form').submit()

# Current residence checkbox
enableDisableResidenceEnd = ->
  if $('#residence_current').is(':checked')
    $('#residence_end').prop('disabled', true)
  else
    $('#residence_end').prop('disabled', false)

$ ->
  $('.submit-next').click(submitAndNext)
  $('.submit-previous').click(submitAndPrevious)

  enableDisableResidenceEnd()
  $('#residence_current').change(enableDisableResidenceEnd)

# Current employment checkbox
enableDisableEmploymentEnd = ->
  if $('#employment_current').is(':checked')
    $('#employment_end_date').prop('disabled', true)
  else
    $('#employment_end_date').prop('disabled', false)

$ ->
  $('.submit-next').click(submitAndNext)
  $('.submit-previous').click(submitAndPrevious)

  enableDisableEmploymentEnd()
  $('#employment_current').change(enableDisableEmploymentEnd)