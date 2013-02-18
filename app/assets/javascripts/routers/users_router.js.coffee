class Boardwalk.Routers.Users extends Backbone.Router
  routes:
    '': 'new'
    'users': 'index'
    'users/:id': 'show'

  index: ->
    collection = new Boardwalk.Collections.Users()
    layout = new Boardwalk.Views.DefaultLayout()
    $('#container').replaceWith(layout.render().el)

    collection.fetch
      success: ->
        view = new Boardwalk.Views.UsersIndex(collection: collection)
        Boardwalk.setTitle "User index"

        Boardwalk.content(view.render().el)

  new: ->
    layout = new Boardwalk.Views.DefaultLayout()
    $('#container').replaceWith(layout.render().el)

    view = new Boardwalk.Views.UsersNew(collection: @collection)
    Boardwalk.content(view.render().el)

  show: (id) ->
    layout = new Boardwalk.Views.BoardLayout()
    $('#container').replaceWith(layout.render().el)

    user = new Boardwalk.Models.User id: id

    user.fetch
      success: (f) ->
        console.log f
        view = new Boardwalk.Views.UsersShow(model: user)
        Boardwalk.setTitle(_.string.titleize(user.get('username')))
        Boardwalk.content(view.render().el)
