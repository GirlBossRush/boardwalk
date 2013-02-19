class Boardwalk.Routers.Sessions extends Backbone.Router
  routes:
    'login': 'new'

  new: ->
    layout = new Boardwalk.Views.DefaultLayout()
    $('#container').replaceWith(layout.render().el)

    view = new Boardwalk.Views.SessionsNew()

    Boardwalk.setTitle("Log in")
    Boardwalk.content(view.render().el)