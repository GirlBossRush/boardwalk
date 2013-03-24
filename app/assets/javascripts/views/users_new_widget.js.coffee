class Boardwalk.Views.UsersNewWidget extends Backbone.View
  tag: 'section'
  attributes:
    id: 'new-user'
    class: 'new-widget modal'

  template: JST['users/new_widget']

  render: ->
    $(@el).html(@template(user: @model))
    this

