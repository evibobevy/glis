$ ->
  $('a.fancybox').fancybox
    padding: 0
    parent: 'body'
    type: 'ajax'
    closeBtn: false
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

@alert_box = (level, msg) ->
  html = \
    "<div class='alert fade in alert-#{level}'>
  <button class='close' data-dismiss='alert'>\&times;</button>#{msg}</div>"
  return html