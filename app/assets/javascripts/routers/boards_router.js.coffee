class Boardwalk.Routers.Boards extends Backbone.Router
  routes:
    'boards/': 'index'
    'boards/:id': 'show'

  initialize: ->
    @collection = new Boardwalk.Collections.Boards()
    @collection.reset($('#data-store').data 'boards')

  index: ->
    view = new Boardwalk.Views.BoardsIndex(collection: @collection)
    $('#data-store').html(view.render().el)

  show: (id) ->
    alert "Board #{id}"