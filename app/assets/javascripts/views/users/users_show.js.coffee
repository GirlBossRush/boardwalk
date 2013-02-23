class Boardwalk.Views.UsersShow extends Backbone.View
  tagName: 'section'
  attributes:
    class: 'board'
  template: JST['users/show']

  render: ->
    $(@el).html(@template(user: @model))
    this
