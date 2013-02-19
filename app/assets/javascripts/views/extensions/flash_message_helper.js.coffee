_.extend Boardwalk,
  flashMessage: (input) ->
    output = ''
    if typeof(input) == 'object'
      _.each input, (message) ->
        output += "<li>#{message}</li>"

    else if typeof(input) == 'string'
      output = "<li>#{input}</li>"

    $flash = $('#flash')
    $messages = $flash.children('.messages')

    $messages.html(output)

    $flash.stop(true, true).fadeIn () ->
      $(this).delay(8000).fadeOut()