#$ ->
#  $('a.fancybox').fancybox
#    padding: 0
#    parent: 'body'
#    type: 'ajax'
#    closeBtn: true
#    autoSize: false
#    height: 'auto'
#    minWidth: 100
#    arrows: false
#    beforeLoad: ->
#      @width = parseInt(@element.data('fancybox-width'))
#      return
#    helpers:
#      overlay:
#        css:
#          'background': 'rgb(58, 42, 45, 0.15)'
#  return