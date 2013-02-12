class Boardwalk.Routers.Boards extends Backbone.Router
  routes:
    'boards': 'index'
    'boards/:id': 'show'

  initialize: ->
    @collection = new Boardwalk.Collections.Boards()

  index: ->
    @collection.fetch()
    view = new Boardwalk.Views.BoardsIndex(collection: @collection)
    Boardwalk.content.html(view.render().el)

  show: (id) ->
    board = new Boardwalk.Models.Board id: id

    board.fetch
      success: (response, object) ->
        console.log object
