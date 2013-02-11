class Boardwalk.Routers.Users extends Backbone.Router
  routes:
    '': 'index'
    'users/:id': 'show'

  initialize: ->
    @collection = new Boardwalk.Collections.Users()
    @collection.fetch()

  index: ->
    view = new Boardwalk.Views.UsersIndex(collection: @collection)
    $('#content').html(view.render().el)
