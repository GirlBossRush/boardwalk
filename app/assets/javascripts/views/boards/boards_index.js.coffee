class Boardwalk.Views.BoardsIndex extends Backbone.View

  template: JST['boards/index']

  initialize: ->
    @collection.on('reset', @render, this)

  render: ->
    $(@el).html(@template(boards: @collection))
    this