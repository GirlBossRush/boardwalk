class Boardwalk.Views.BoardLayout extends Backbone.View
  attributes: ->
    id: 'container'
    class: 'fullscreen'
  template: JST['layouts/board']

  events:
    'click #home': "rootURL"
    'click #settings, #user .close-modal': "toggleUserSettings"
    'click #login': "loginURL"
    'click #logout': "logoutURL"

    'click #edit-widgets': 'toggleEditWidgets'
    'click .widget .delete-widget': 'deleteWidget'
    'click #zoom-toggle': 'toggleZoom'
    'dblclick .board': 'toggleNewWidget'
  initialize: (params) ->
    @collection = params.user

  render: ->
    @$el.html(@template(@options))

    this

  toggleZoom: (e) ->
    e.preventDefault()
    $('#container').toggleClass('zoomed-in')
    if $('#container').hasClass('zoomed-in')
      $("#zoom-toggle").text('Zoom Out')
    else
      $("#zoom-toggle").text('Zoom In')


  toggleNewWidget: (e) ->
    e.preventDefault()
    if $('#container').hasClass('editing')
      # Send the mouse click off to our new widget view.
      @trigger("toggleNewWidget", x: e.offsetX, y: e.offsetY)
      $('#site-veil, #new-widget-modal').fadeToggle()

  toggleEditWidgets: (e) ->
    e.preventDefault()

    # FIXME: Due to various jQuery nonsense, draggable elements will be erratic when zoomed in.
    #        One solution is to half all the movements, however the collision detection is still terrible.
    #$("#container").removeClass('zoomed-in')
    $widgets = $('.widget')

    if $("#container").hasClass('editing')
      $("#container").removeClass('editing')
      $widgets.draggable('destroy')
      $(e.target).text("Edit")

     # Start saving the changed widgets
      @collection.widgets.each (widget, i) ->
        if widget.hasChanged()
          widget.save()
    else
      $(e.target).text("Done Editing")
      $("#container").addClass('editing')
      Boardwalk.flashMessage("Double click anywhere to add new content.")
      @setDraggable()

  setDraggable: (e) =>
    $widgets = $('.widget')

    $widgets.draggable
      containment: ".board .inner"
      scroll: false
      snap: true
      snapMode: 'outer'
      stack: ".widget"
      revert: 'invalid'
      refreshPositions: true

      stop: (event, ui) =>
        # Prevent collisions
        $widgets.draggable('option','revert','invalid')

        widget = @collection.widgets.get(ui.helper.attr('id'))
        widget.set(x: ui.position.left, y: ui.position.top)
      drag: (event, ui) ->
        $(event.target).find('h2').text("X: #{ui.position.left} Y: #{ui.position.top}")


    $('.board .inner').droppable
      tolerance: 'fit'

    $widgets.droppable
      greedy: true
      tolerance: 'intersect'
      hoverClass: "overlap"

      drop: (event, ui) ->
        ui.draggable.draggable('option','revert',true)

  toggleUserSettings: (e) ->
    e.preventDefault()
    $('#site-veil, #user').fadeToggle()

  deleteWidget: (e) ->
    e.preventDefault()

    $widget = $(e.target).parents('.widget')

    widgetModel = @collection.widgets.get($widget.attr('id'))
    $widget.fadeOut 200, ->
      widgetModel.destroy
        wait: true
        success: ->
          $widget.remove()
  rootURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/', true)

  loginURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/login', true)

  logoutURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/logout', true)

