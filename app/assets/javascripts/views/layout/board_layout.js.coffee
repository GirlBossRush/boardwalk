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
    'click #new-widget-modal .close-modal': 'toggleNewWidget'
    'click .widget .delete-widget': 'deleteWidget'
    'dblclick .board': 'doubleClickHandler'


  initialize: (params) ->
    @collection = params.user

  render: ->
    @$el.html(@template(@options))

    #if Modernizr.touch == false
    debiki.Utterscroll.enable
      scrollstoppers: ".widget:not('.zoomed')"
    this

  # Backbone seems to have trouble with two separate double click actions.
  # Let's delegate from here.
  doubleClickHandler: (e) =>
    if $('#container').hasClass('editing')
      @toggleNewWidget(e)
    else
      @toggleZoom(e)

  toggleZoom: (e) ->
    $('#container').toggleClass('zoomed-in')

  toggleNewWidget: (e) ->
    e.preventDefault()
    if $('#container').hasClass('editing')
      # Send the mouse click off to our new widget view.
      @trigger("toggleNewWidget", x: e.offsetX, y: e.offsetY)
      $('#site-veil, #new-widget-modal').fadeToggle()

  toggleEditWidgets: (e) ->
    e.preventDefault()

    $("#container").removeClass('zoomed-in')
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
      @setDraggable()

  setDraggable: (e) =>
    $widgets = $('.widget')

    $widgets.draggable
      containment: ".board .inner"
      scroll: false
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

    window.foo = e
    $widget= $(foo.target).parents('.widget')

    widget = @collection.widgets.get($widget.attr('id'))
    widget.destroy
      wait: true
      success: ->
        $widget.fadeOut 200, ->
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

