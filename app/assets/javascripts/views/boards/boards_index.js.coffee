class Boardwalk.Views.BoardsIndex extends Backbone.View

  template: JST['boards/index']

  events:
    'submit #new_board': 'createBoard'

  # initialize: ->
  #   @collection.on('reset', @render, this)
  #   @collection.on('add', @appendBoard, this)

  render: ->
    $(@el).html(@template())
    @collection.each(@appendBoard)
    this

  appendBoard: (board) =>
    view = new Boardwalk.Views.Board(model: board)
    @$("#boards").append(view.render().el)

  createBoard: (event) ->
    event.preventDefault()
    attributes = name: $('#new_board_name').val()
    @collection.create attributes,
      wait: true
      success: ->
        $('#new_board')[0].reset()
      error: @handleError

  handleError: (board, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages