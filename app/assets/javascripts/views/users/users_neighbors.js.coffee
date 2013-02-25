class Boardwalk.Views.UsersNeighbors extends Backbone.View
  tagName: 'section'
  attributes:
    class: 'neighbors'
  template: JST['users/neighbors']

  render: ->
    $(@el).html(@template(user: @model))
    this
