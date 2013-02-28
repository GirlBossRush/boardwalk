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
    user = $.cookie('current_user')
    if user._id
      session = new Boardwalk.Models.Session(id: user._id)
      session.destroy
        navigate: true
    else
      # The user must have navigated here.
      Backbone.history.navigate('/login', true)
