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

    $('.widget').draggable
      grid: [5, 5]
      containment: ".board"
      scroll: false
      stack: ".widget"
      revert: 'invalid'
      stop: ->
        $(this).draggable('option','revert','invalid')

    $('.board').droppable
      tolerance: 'fit'

    $('.widget').droppable
      greedy: true
      tolerance: 'touch'
      hoverClass: "overlap"
      drop: (event, ui) ->
        ui.draggable.draggable('option','revert',true)

