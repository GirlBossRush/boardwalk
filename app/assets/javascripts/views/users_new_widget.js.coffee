class Boardwalk.Views.UsersNewWidget extends Backbone.View
  tag: 'section'
  attributes:
    id: 'new-widget-modal'
    class: 'new-widget-modal modal'

  template: JST['users/new_widget']

  events:
    'submit #new-widget-form': 'createWidget'

  initialize: ->
    @$ = $

  render: ->
    $(@el).html(@template(user: @model))
    @fileUploadInit()
    @

# Message to future-people:
# I'm well aware of the frustrating implementation below.
# Backbone integrates poorly with jQuery File Upload but in the name of progress,
# I'm going to move forward and pretty this up a different day.

  catchWidgetCoords: (data) =>
    # The jQuery File Upload devs seems to think this is the best way
    # to get more parameters in the form.
    $form = @$el.find("form")
    $form.append("<input type='hidden' name='widget[x]' value='#{data.x}'>")
    $form.append("<input type='hidden' name='widget[y]' value='#{data.y}'>")

  fileUploadInit: =>
    @$el.fileupload
      add: (e, data) =>
        @widgetFileUpload = data
        console.log "started uploading", e, data, @
      done: (e, data) =>
        console.log "file upload done", data.result
        newWidget = new Boardwalk.Models.Widget(data.result)
        @model.widgets.add newWidget

        @appendWidget(newWidget)


  createWidget: (e) =>
    e.preventDefault()

    if @hasOwnProperty('widgetFileUpload')
      @widgetFileUpload.submit()
    else
      console.log "new widget without file", @
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
    @trigger('createWidget', null)
    $('#new-widget-modal, #site-veil').fadeOut()
