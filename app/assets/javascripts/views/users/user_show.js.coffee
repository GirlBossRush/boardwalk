class Boardwalk.Views.UsersShow extends Backbone.View

  template: JST['users/show']

  events:
    'click #edit-widgets': 'editWidgets'

  render: ->
    $(@el).html(@template(user: @model))
    this

  editWidgets: (event) ->
    event.preventDefault()
    $(".widget").draggable({ grid: [ 10, 10 ] })