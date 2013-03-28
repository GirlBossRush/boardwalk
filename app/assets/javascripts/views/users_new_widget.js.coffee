class Boardwalk.Views.UsersNewWidget extends Backbone.View
  tag: 'section'
  attributes:
    id: 'new-widget-modal'
    class: 'new-widget-modal modal'

  template: JST['users/new_widget']

  events:
    'submit #new-widget-form': 'createWidget'

  catchWidgetCoords: (data) =>
    @coords = data

  initialize: ->
    @$ = $

  render: ->
    $(@el).html(@template(user: @model))
    @uploadImage()
    @

  uploadImage: =>
    @$el.fileupload
      add: (e, data) ->
        console.log "started uploading", e, data

        data.submit()


      done: (e, data) ->
        console.log "done uploading", e, data

  createWidget: (e) =>
    e.preventDefault()
    $form = $(e.target)
    attributes = $form.serializeForm()
    _.extend(attributes.widget, @coords)
    console.log attributes
    @model.widgets.create attributes.widget,
      wait: true
      success: (model) =>
        console.log "From the success", model
        widgetView = new Boardwalk.Views.Widget({model})
        $('.board .widgets').append(widgetView.render().el)

        @$('time').timeago()
        @trigger('createWidget', null)
        $('#new-widget-modal, #site-veil').fadeOut()

