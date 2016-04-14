# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('a.fancybox').fancybox
    padding: 0
    parent: 'body'
    type: 'ajax'
    closeBtn: true
    autoSize: false
    height: 'auto'
    minWidth: 100
    arrows: false
    beforeLoad: ->
      @width = parseInt(@element.data('fancybox-width'))
      return
    helpers:
      overlay:
        css:
          'background': 'rgb(58, 42, 45, 0.15)'
  return
