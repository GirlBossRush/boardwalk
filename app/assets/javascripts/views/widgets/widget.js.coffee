class Boardwalk.Views.Widget extends Backbone.View
  template: JST['widgets/widget']
  tagName: 'article'
  attributes: ->
    class: =>
      ['widget', @model.get('type')].join(' ')
    id: =>
      @model.id
    'data-user-id': =>
      @model.get('user_id')

    style: =>
      "top: #{@model.get('y')}px; left: #{@model.get('x')}px;"
  render: ->
    $(@el).html(@template(widget: @model))
    this


