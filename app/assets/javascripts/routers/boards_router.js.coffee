class Boardwalk.Routers.Boards extends Backbone.Router
  routes:
    '': 'index'
    'boards/:id': 'show'

  initialize: ->
    @collection = new Boardwalk.Collections.Boards()
    @collection.reset($('#container').data 'boards')

  index: ->
    view = new Boardwalk.Views.BoardsIndex(collection: @collection)
    $('#container').html(view.render().el)

  show: (id) ->
    alert "Board #{id}"