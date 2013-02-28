class Boardwalk.Views.BoardLayout extends Backbone.View
  attributes: ->
    id: 'container'
    class: 'fullscreen'

  template: JST['layouts/board']

  events:
    'click #home': "rootURL"
    'click #login': "loginURL"
    'click #logout': "logoutURL"
    'click #edit-widgets': 'toggleEditWidgets'
    'dblclick .board': "toggleZoom"

  render: () ->
    @$el.html(@template(@options))
    if Modernizr.touch == false
      debiki.Utterscroll.enable
        scrollstoppers: ".widget:not('.zoomed')"
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
    $container = $("#container")
    $container.toggleClass('zoomed-in')
    $widget = $('.widget')

    $widget.toggleClass('zoomed')

    # REFACTOR: There's gotta be an easier way to deal with this.
    if $widget.hasClass('ui-draggable') == true
      if $widget.draggable('option', 'disabled') == true
        $widget.draggable('option', 'disabled', false)
      else
        $widget.draggable('option', 'disabled', true)

  toggleEditWidgets: (e) ->
    e.preventDefault()
    $widget = $('.widget')
    if $widget.hasClass('ui-draggable') == true
      $widget.draggable('destroy')
      $(e.target).text("Edit")
    else
      $(e.target).text("Save")
      $('.widget').draggable
        containment: ".board .inner"
        scroll: false
        grid: [2,2]
        snap: true
        snapMode: 'outer'
        stack: ".widget"
        revert: 'invalid'
        refreshPositions: true

        stop: ->
          $(@).draggable('option','revert','invalid')

        drag: (event, ui) ->
          $(event.target).find('h2').text("X: #{ui.position.left} Y: #{ui.position.top}")


      $('.board .inner').droppable
        tolerance: 'fit'

      $widget.droppable
        greedy: true
        tolerance: 'intersect'
        hoverClass: "overlap"

        drop: (event, ui) ->
          ui.draggable.draggable('option','revert',true)

