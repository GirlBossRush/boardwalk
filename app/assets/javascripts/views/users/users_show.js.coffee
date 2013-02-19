class Boardwalk.Views.UsersShow extends Backbone.View

  template: JST['users/show']

  events:
    'click #edit-widgets': 'editWidgets'

  render: ->
    $(@el).html(@template(user: @model))
    this

  editWidgets: (event) ->
    event.preventDefault()
    $(".widget").draggable
      grid: [20, 20]
      snap: true
      snapMode: "outer"
      stack: ".widget"