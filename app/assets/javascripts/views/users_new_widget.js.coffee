class Boardwalk.Views.UsersNewWidget extends Backbone.View
  tag: 'section'
  attributes:
    id: 'new-widget-modal'
    class: 'new-widget-modal modal'

  template: JST['users/new_widget']

  events:
    'submit #new-widget-form': 'createWidget'
    'click .close-modal': 'closeWidgetModal'

  initialize: ->
    @$ = $

  # Message to future-people:
  # I'm well aware of the frustrating implementation below.
  # Backbone integrates poorly with jQuery File Upload but in the name of progress,
  # I'm going to move forward and pretty this up a different day.

  render: ->
    $(@el).html(@template(user: @model))
    @fileUploadInit()
    @

  closeWidgetModal: (e) ->
    e.preventDefault()
    $('#site-veil, #new-widget-modal').fadeToggle 250, =>
      $fakeFileUpload = @$el.find(".fake-file-upload")
      $fakeFileUpload.attr("data-file", "No file selected")
    # FIXME: Files do not get cleared even if the form is closed.

  catchWidgetCoords: (data) =>
    # The jQuery File Upload devs seems to think this is the best way
    # to get more parameters in the form. We need to set the widget's
    # coordinates from the user's click position. A binding has been
    # set to trigger from the board_layout.
    $form = @$el.find("form")
    $form.append("<input type='hidden' name='widget[x]' value='#{data.x}'>")
    $form.append("<input type='hidden' name='widget[y]' value='#{data.y}'>")

  fileUploadInit: =>
    @$el.fileupload
      add: (e, data) =>
        @widgetFileUpload = data

        $fakeFileUpload = @$el.find(".fake-file-upload")
        # It seems that Chrome doesn't redraw with $('foo').data() setting.
        $fakeFileUpload.attr("data-file", @widgetFileUpload.files[0].name)
      done: (e, data) =>
        newWidget = new Boardwalk.Models.Widget(data.result)
        @model.widgets.add newWidget
        @appendWidget(newWidget)

        delete @widgetFileUpload
        @$el.fileupload('destroy')
        @fileUploadInit()


  createWidget: (e) =>
    e.preventDefault()

    if @hasOwnProperty('widgetFileUpload')
      @widgetFileUpload.submit()
    else
      $form = $(e.target)
      attributes = $form.serializeForm()

      @model.widgets.create attributes.widget,
        wait: true
        success: (model) =>
          @appendWidget(model)

  appendWidget: (widget) ->
    widgetView = new Boardwalk.Views.Widget(model: widget)
    $('.board .widgets').append(widgetView.render().el)
    @$('time').timeago()

    # We need to tell jQuery there are new widgets to set draggable.
    @trigger('createWidget', null)

    $('#new-widget-modal, #site-veil').fadeOut()
    @$el.find('form')[0].reset()
