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

  destroy: ->
    user_id = $.cookie('user_id')
    if user_id
      # Regardless of the server's response, we should get rid of the cookie.
      $.removeCookie('user_id')

      session = new Boardwalk.Models.Session(id: user_id)
      session.destroy
        success: ->
          Backbone.history.navigate('/login', true)
    else
      # The user must have navigated here.
      Backbone.history.navigate('/login', true)
