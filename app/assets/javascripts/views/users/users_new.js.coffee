class Boardwalk.Views.UsersNew extends Backbone.View

  template: JST['users/new']

  events:
    'submit #new-user': 'createUser'
    'keyup #user_username': 'checkUsername'
    'keyup #user_password_confirmation': 'checkPassword'

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

  checkUsername: (event) ->
    $input = $(event.target)
    username = $input.val()
    $.getJSON "api/check/#{username}", {}, (response) ->
      if response.available == false
        $input[0].setCustomValidity(response.message)
      else
        $input[0].setCustomValidity(null)

  checkPassword: (event) ->
    $input = $(event.target)
    $inputMatch = $("##{$input.attr('matches')}")

    if $input.val() != $inputMatch.val()
      $input[0].setCustomValidity("Passwords do not match.")
    else
      $input[0].setCustomValidity(null)