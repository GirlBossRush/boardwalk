class Boardwalk.Views.Widget extends Backbone.View
  template: JST['widgets/widget']
  tagName: 'article'
  attributes: ->
    class: =>
      ['widget', @model.get('type')].join(' ')
    id: =>
      @model.id
    style: =>
      "top: #{@model.get('y')}px; left: #{@model.get('x')}px;"
  render: ->
    $(@el).html(@template(widget: @model))
    this


