class Boardwalk.Views.Board extends Backbone.View
  template: JST['boards/board']
  tagName: 'li'

  events:
    'click': 'showBoard'

  render: ->
    $(@el).html(@template(board: @model))
    this

  showBoard: ->
    Backbone.history.navigate("boards/#{@model.get('_id')}", true)