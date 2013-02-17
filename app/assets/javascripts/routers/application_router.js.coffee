class Boardwalk.Routers.Application extends Backbone.Router
  routes:
    '*undefined': 'notFound'

  before:
    '': ->
      layout = new Boardwalk.Views.DefaultLayout()
      $('body').prepend(layout.render().el)

  notFound: (path) ->
    view = new Boardwalk.Views.NotFound()
    view.setTitle "Page not found"

    Boardwalk.content(view.render(path: path).el)