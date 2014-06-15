# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  changeSection = ->
    hash = window.location.hash
    sectionId = hash.substring 1
    $('.section').each ()->
      section = $ this
      if section.attr('id') is sectionId
        section.toggleClass 'hide', false
      else
        section.toggleClass 'hide', true
    $('.wizard-nav a').each ()->
      link = $ this
      parent = link.parent()
      if link.attr('href') is hash
        parent.toggleClass 'active', true
      else
        parent.toggleClass 'active', false

  $(window).on 'hashchange', changeSection

  firstSectionHash = $('.wizard-nav a').eq(0).attr 'href'
  if not window.location.hash.length
    window.location.hash = firstSectionHash
  else
    changeSection()
