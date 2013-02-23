class Boardwalk.Routers.Sessions extends Backbone.Router
  routes:
    'login': 'new'
    'logout': 'destroy'

  new: ->
    layout = new Boardwalk.Views.DefaultLayout()
    $('#container').replaceWith(layout.render().el)

    view = new Boardwalk.Views.SessionsNew()

    Boardwalk.setTitle("Log in")
    Boardwalk.content(view.render().el)

  logout: ->
    user_id = $.cookie('user_id')
    if user_id
      session = new Boardwalk.Models.Sessions(id: user_id)
      session.destroy
        success: ->
          $.removeCookie('user_id')