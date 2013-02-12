class Boardwalk.Routers.Users extends Backbone.Router
  routes:
    '': 'new'
    'users': 'index'
    'users/:id': 'show'

  initialize: ->
    @collection = new Boardwalk.Collections.Users()

  index: ->
    @collection.fetch()
    view = new Boardwalk.Views.UsersIndex(collection: @collection)
    Boardwalk.content.html(view.render().el)

  new: ->
    view = new Boardwalk.Views.UsersNew(collection: @collection)
    Boardwalk.content.html(view.render().el)

  show: ->
    board = new Boardwalk.Models.User id: id

    board.fetch
      success: (response, object) ->
        console.log object
        view = new Boardwalk.Views.UsersShow(object)
        Boardwalk.content.html(view.render().el)


