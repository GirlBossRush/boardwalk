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
    currentUser = new Boardwalk.Models.User($.cookie('current_user'))
    if currentUser.get('username')
      Backbone.history.navigate("users/#{currentUser.get('username')}", true)
    else
      layout = new Boardwalk.Views.DefaultLayout()
      $('#container').replaceWith(layout.render().el)

      view = new Boardwalk.Views.UsersNew()

      Boardwalk.setTitle("Express yourself")
      Boardwalk.content(view.render().el)

  show: (id) ->
    currentUser = new Boardwalk.Models.User($.cookie('current_user'))
    user = new Boardwalk.Models.User _id: id

    user.fetch
      success: ->
        Boardwalk.setTitle(user.get('username'))

        layout = new Boardwalk.Views.BoardLayout({user, currentUser})
        $('#container').replaceWith(layout.render().el)

        user.initWidgets()
        user.widgets.fetch
          success: ->
            view = new Boardwalk.Views.UsersShow(model: user, collection: user.widgets)
            Boardwalk.content(view.render().el)

      error: ->
        layout = new Boardwalk.Views.DefaultLayout()
        $('#container').replaceWith(layout.render().el)

        view = new Boardwalk.Views.NotFound()
        Boardwalk.setTitle "Page not found"

        Boardwalk.content(view.render(path: id).el)