$(document).ajaxError (event, response) ->
  if response.status == 422
    errors = []
    errorResponse = $.parseJSON(response.responseText).errors

    for attribute, messages of errorResponse
      errors.push("#{attribute} #{message}") for message in messages

    Boardwalk.flashMessage(errors)