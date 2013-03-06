class Boardwalk.Views.UsersEdit extends Backbone.View
  tag: 'section'
  attributes:
    id: 'user'
    class: 'edit-user modal'

  template: JST['users/edit']

  events:
    'submit #edit-user': 'updateUser'
    'click .delete-neighbor': 'deleteNeighbor'
    'keyup #user-password-confirmation': 'checkPassword'

  render: ->
    $(@el).html(@template(user: @model))
    @$('time').timeago()
    this


  deleteNeighbor: (e) ->
    e.preventDefault()
    neighborID = $(e.target).attr('for')

    $("##{neighborID}, a[for='#{neighborID}']").fadeOut 200, ->
      @.remove()

  updateUser: (e) ->
    e.preventDefault()

    $form = $(e.target)
    attributes = $form.serializeForm()
    @model.set(attributes)
    @model.save()

  # TODO: This method already exists for the user creation view.
  #       How can I write this once and get the method elsewhere? Modules?
  checkPassword: (e) ->
    $input = $(e.target)
    $inputMatch = $("##{$input.attr('matches')}")

    if $input.val() != $inputMatch.val()
      $input[0].setCustomValidity("Passwords do not match.")
    else
      $input[0].setCustomValidity(null)