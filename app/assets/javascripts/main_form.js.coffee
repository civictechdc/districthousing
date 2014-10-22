changeSection = ->
  hash = window.location.hash
  sectionId = hash.substring 1
  $('.section').each ()->
    section = $ @
    if section.attr('id') is sectionId
      section.toggleClass 'hide', false
    else
      section.toggleClass 'hide', true
  $('.wizard-nav a').each ()->
    link = $ @
    parent = link.parent()
    if link.attr('href') is hash
      parent.toggleClass 'active', true
    else
      parent.toggleClass 'active', false

scrollToTop = ->
  window.scrollTo 0, 0

showDownloadWarning = ->
  $('#download-warning').modal()

submitUpdateForm = ->
  $('.update-button').submit()

handleDownloadButton = ->
  showDownloadWarning()
  submitUpdateForm()

initialize = (e)->
  $('#download-button').click(handleDownloadButton)
  firstSectionHash = $('.wizard-nav a').eq(0).attr 'href'
  if window.location.hash.length <= 1
    window.location.hash = firstSectionHash
  else
    changeSection()

if window.location.pathname.match(/\/apply$/)
  $ ->
    $(window).on 'hashchange', changeSection
    $(window).on 'hashchange', scrollToTop
    $(document).ajaxComplete initialize
    initialize()
