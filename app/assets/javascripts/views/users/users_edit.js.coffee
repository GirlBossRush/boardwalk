class Boardwalk.Views.UsersEdit extends Backbone.View
  tag: 'section'
  attributes:
    id: 'user'
    class: 'edit-user modal'

  template: JST['users/edit']
  newNeighbor: JST['users/new_neighbor']

  events:
    'click #user-submit': 'updateUser'
    'click .delete-neighbor': 'deleteNeighbor'
    'keyup #user-password-confirmation': 'checkPassword'
    'keyup .user-new-neighbor': 'addNeighborToForm'

  render: ->
    @$el.html(@template(user: @model))

    @$('time').timeago()
    this

  addNeighborToForm: (e) =>
    # TODO: A new neighbor form should be added when the user has
    #       4 neighbors to begin with and deletes one.
    $input = $(e.target)
    $el = @$el

    if e.keyCode == 13 # Enter
      # "Add" neighbor to form.
      e.preventDefault()
      $input.parent(".field").removeClass('writable')
      $input.prop('readonly', true)

      $(".user-neighbors").append(@newNeighbor())
      $(".user-neighbors .user-new-neighbor:last").focus()

    else if e.keyCode not in [9, 18, 37, 38, 39, 40] and not e.ctrlKey
      # The user must be searching for a neighbor username.
      username = $input.val()
      $dataList = $el.find('#user-search')

      if username.length > 0
        $.getJSON "/api/search/#{username}", {}, (response) ->
          $dataList.empty()
          _.each response, (user) ->
            $dataList.append("<option value='#{user.username}'>#{user.email}</option>")



  deleteNeighbor: (e) ->
    e.preventDefault()
    $fieldContainer = $(e.target).parent('.field')

    $fieldContainer.fadeOut 200, ->
      @remove()

  updateUser: (e) ->
    e.preventDefault()
    attributes = @$el.serializeForm()
    @model.set(attributes.user)
    @model.save null,
      wait: true
      success: ->
        # $('#site-veil, #user').fadeOut()
        window.location.reload()

  # TODO: This method already exists for the user creation view.
  #       How can I write this once and get the method elsewhere? Modules?
  checkPassword: (e) ->
    $input = $(e.target)
    $inputMatch = $("##{$input.attr('matches')}")

    if $input.val() != $inputMatch.val()
      $input[0].setCustomValidity("Passwords do not match.")
    else
      $input[0].setCustomValidity(null)
