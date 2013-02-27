class Boardwalk.Views.Widget extends Backbone.View
  template: JST['widgets/widget']
  tagName: 'article'
  attributes:
    class: 'widget'

  render: ->
    $(@el).html(@template(widget: @model))
    this


