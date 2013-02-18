class Boardwalk.Routers.Application extends Backbone.Router
  routes:
    '*undefined': 'notFound'

  notFound: (path) ->
    layout = new Boardwalk.Views.DefaultLayout()
    $('#container').replaceWith(layout.render().el)

    view = new Boardwalk.Views.NotFound()
    Boardwalk.setTitle "Page not found"

    Boardwalk.content(view.render(path: path).el)