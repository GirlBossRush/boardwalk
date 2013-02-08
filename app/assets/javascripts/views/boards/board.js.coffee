class Boardwalk.Views.Board extends Backbone.View
  template: JST['boards/board']
  tagName: 'li'

  events:
    'click': 'showEntry'

  render: ->
    $(@el).html(@template(board: @model))
    this

  showEntry: ->
    Backbone.history.navigate("boards/#{@model.get('_id')}", true)