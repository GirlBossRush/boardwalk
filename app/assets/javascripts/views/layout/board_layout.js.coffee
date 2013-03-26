class Boardwalk.Views.BoardLayout extends Backbone.View
  attributes: ->
    id: 'container'
    class: 'fullscreen'
  template: JST['layouts/board']
  events:
    'click #home': "rootURL"
    'click #settings': "toggleUserSettings"
    'click #login': "loginURL"
    'click #logout': "logoutURL"
    'click #edit-widgets': 'toggleEditWidgets'
    'dblclick .board': "toggleZoom"

  initialize: (params) ->
    #REFACTOR: We're fetching twice. It'd be proper to just the data from the user model.
    # @collection.fetch()
    @collection = params.user
  render: ->
    @$el.html(@template(@options))

    if Modernizr.touch == false
      debiki.Utterscroll.enable
        scrollstoppers: ".widget:not('.zoomed')"
    this


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
      $(e.target).text("Save")
      $("#container").addClass('editing')

      $widgets.draggable
        containment: ".board .inner"
        scroll: false
        grid: [10,10]
        snapMode: 'outer'
        stack: ".widget"
        revert: 'invalid'
        refreshPositions: true

        stop: (event, ui) =>
          widget = @collection.widgets.get(ui.helper.attr('id'))
          widget.set(x: ui.position.left, y: ui.position.top)
          window.w = widget

          # Prevent collisions
          $widgets.draggable('option','revert','invalid')

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

  rootURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/', true)

  loginURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/login', true)

  logoutURL: (e) ->
    e.preventDefault()
    Backbone.history.navigate('/logout', true)

  toggleUserSettings: (e) ->
    e.preventDefault()
    $('#site-veil, #user').fadeToggle()
