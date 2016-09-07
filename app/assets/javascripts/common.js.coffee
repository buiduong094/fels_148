$(document).on 'ready page:load', ->
  $('div.alert').delay(4000).slideUp()
  cancel_function = ->
    window.history.back()
