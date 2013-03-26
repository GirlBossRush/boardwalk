class Boardwalk.Views.UsersNewWidget extends Backbone.View
  tag: 'section'
  attributes:
    id: 'new-user'
    class: 'new-widget modal'

  template: JST['users/new_widget']
  events:
    'submit #new-widget': 'createWidget'

  render: ->
    $(@el).html(@template(user: @model))
    this

  createWidget: (e) ->
    e.preventDefault()
    $form = $(e.target)
    attributes = $form.serializeForm()
    console.log attributes

    @model.widgets.create attributes,
      wait: true
      success: ->
        console.log "SUCCESS!"
    window.foo = @model
