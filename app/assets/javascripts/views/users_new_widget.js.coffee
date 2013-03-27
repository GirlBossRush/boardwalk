class Boardwalk.Views.UsersNewWidget extends Backbone.View
  tag: 'section'
  attributes:
    id: 'new-widget-modal'
    class: 'new-widget-modal modal'

  template: JST['users/new_widget']

  widget: JST['widgets/widget']

  events:
    'submit #new-widget-form': 'createWidget'

  catchWidgetCoords: (data) =>
    @coords = data

  render: ->
    $(@el).html(@template(user: @model))
    this

  createWidget: (e) ->
    e.preventDefault()
    $form = $(e.target)
    attributes = $form.serializeForm()
    _.extend(attributes.widget, @coords)

    @model.widgets.create attributes,
      wait: true
      success: (model) ->
        console.log model
        $('#new-widget-modal, #site-veil').fadeOut()
