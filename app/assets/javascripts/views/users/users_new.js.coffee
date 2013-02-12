class Boardwalk.Views.UsersNew extends Backbone.View

  template: JST['users/new']

  events:
    'submit #new-user': 'createUser'

  render: ->
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