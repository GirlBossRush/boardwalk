class Boardwalk.Views.BoardLayout extends Backbone.View
  attributes: ->
    id: 'container'
    class: 'fullscreen'

  template: JST['layouts/board']

  events:
    'click #home': "rootURL"
    'click #login': "loginURL"
    'click #logout': "logoutURL"
    'click #edit-widgets': 'editWidgets'
    'dblclick .board': "toggleZoom"

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

  toggleZoom: (e) ->
    $('#container').toggleClass('zoomed-out')

  editWidgets: (e) ->
    e.preventDefault()

    $('.widget').draggable
      grid: [5, 5]
      containment: ".board .inner"
      scroll: false
      stack: ".widget"
      revert: 'invalid'
      refreshPositions: true
      stop: ->
        $(this).draggable('option','revert','invalid')

    $('.board .inner').droppable
      tolerance: 'fit'

    $('.widget').droppable
      greedy: true
      tolerance: 'touch'
      hoverClass: "overlap"
      drop: (event, ui) ->
        ui.draggable.draggable('option','revert',true)

