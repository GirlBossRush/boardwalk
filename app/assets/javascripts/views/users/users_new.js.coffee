class Boardwalk.Views.UsersNew extends Backbone.View

  template: JST['users/new']

  events:
    'submit #new-user': 'createUser'
    'keyup #user-username': 'checkUsername'
    'keyup #user-password-confirmation': 'checkPassword'

  render: ->
    $(@el).html(@template())
    this

  createUser: (e) ->
    e.preventDefault()
    $form = $(e.target)
    attributes = $form.serializeForm()

    user = new Boardwalk.Models.User(attributes.user)

    user.save null,
      wait: true
      success: ->
        session = new Boardwalk.Models.Session(attributes)
        session.save null,
          navigate: true

      error: ->
        $form.find('input:first').focus()

  checkUsername: (e) ->
    $input = $(e.target)
    username = $input.val()
    $.getJSON "api/check/#{username}", {}, (response) ->
      if response.available == false
        $input[0].setCustomValidity(response.message)
      else
        $input[0].setCustomValidity(null)

  checkPassword: (e) ->
    $input = $(e.target)
    $inputMatch = $("##{$input.attr('matches')}")

    if $input.val() != $inputMatch.val()
      $input[0].setCustomValidity("Passwords do not match.")
    else
      $input[0].setCustomValidity(null)

