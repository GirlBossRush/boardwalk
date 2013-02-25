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
    user_id = $.cookie('user_id')
    if user_id
      Backbone.history.navigate("users/#{user_id}", true)
    else
      layout = new Boardwalk.Views.DefaultLayout()
      $('#container').replaceWith(layout.render().el)

      view = new Boardwalk.Views.UsersNew()

      Boardwalk.setTitle("Be somebody")
      Boardwalk.content(view.render().el)

  show: (id) ->
    user = new Boardwalk.Models.User id: id

    user.fetch
      success: ->
        Boardwalk.setTitle(user.get('username'))

        layout = new Boardwalk.Views.BoardLayout(model: user)
        $('#container').replaceWith(layout.render().el)

        view = new Boardwalk.Views.UsersShow(model: user)
        Boardwalk.content(view.render().el)

        neighbors = new Boardwalk.Views.UsersNeighbors(model: user)
        $('#content').prepend(neighbors.render().el)

        if Modernizr.touch == false
          debiki.Utterscroll.enable
            scrollstoppers: '.widget'
