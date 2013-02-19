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

        Boardwalk.setTitle "Users"
        Boardwalk.content(view.render().el)

  new: ->
    layout = new Boardwalk.Views.DefaultLayout()
    $('#container').replaceWith(layout.render().el)

    view = new Boardwalk.Views.UsersNew()

    Boardwalk.setTitle("Be somebody")
    Boardwalk.content(view.render().el)

  show: (id) ->
    user = new Boardwalk.Models.User id: id

    user.fetch
      success: ->
        layout = new Boardwalk.Views.BoardLayout(collection: @collection)
        $('#container').replaceWith(layout.render().el)

        view = new Boardwalk.Views.UsersShow(model: user)
        Boardwalk.setTitle(_.string.titleize(user.get('username')))
        Boardwalk.content(view.render().el)
