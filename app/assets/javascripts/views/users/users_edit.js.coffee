class Boardwalk.Views.UsersEdit extends Backbone.View
  tag: 'section'
  attributes:
    id: 'user'
    class: 'edit-user modal'

  template: JST['users/edit']

  events:
    'submit #edit-user': 'updateUser'

  render: ->
    $(@el).html(@template(user: @model))
    @$('time').timeago()
    this

  updateUser: (e) ->
    e.preventDefault()

    $form = $(e.target)
    attributes = $form.serializeObject()
    window.a = attributes
    window.m = @model
    console.log e, @model
    # @model.save()