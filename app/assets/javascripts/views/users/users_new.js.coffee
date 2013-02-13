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

    @user = new Boardwalk.Models.User(attributes)

    @user.save null,
      wait: true
      success: (model) ->
        $form[0].reset()

      error: ->
        $form.find('input:first').focus()

