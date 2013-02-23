class Boardwalk.Views.BoardLayout extends Backbone.View
  attributes: ->
    id: 'container'

  template: JST['layouts/board']

  events:
    'click #home': "rootURL"
    'click #login': "loginURL"
    'click #logout': "logoutURL"
    'click #edit-widgets': 'editWidgets'

  render: ->
    @$el.html(@template(user: @model))
    this

  rootURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/', true)

  loginURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/login', true)

  logoutURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/logout', true)

  editWidgets: (e) ->
    e.preventDefault()

    $(".widget").draggable
      grid: [10, 10]
      snapMode: "outer"
      stack: ".widget"
      containment: "#content"
      scroll: false