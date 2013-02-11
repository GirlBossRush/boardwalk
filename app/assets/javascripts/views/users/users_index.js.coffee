class Boardwalk.Views.UsersIndex extends Backbone.View

  template: JST['users/index']

  events:
    'submit #new-user': 'createUser'

  render: ->
    console.log "render"
    $(@el).html(@template())
    this

  createUser: (event) ->
    event.preventDefault()
    $form = $('#new-user')
    attributes = $form.serializeObject()
    @collection.create attributes,
      wait: true
      success: ->
        $form[0].reset()
      error: @handleError

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages