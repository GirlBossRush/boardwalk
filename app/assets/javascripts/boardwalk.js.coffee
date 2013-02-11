window.Boardwalk =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Boardwalk.Routers.Boards
    new Boardwalk.Routers.Users
    Backbone.history.start(pushState: true)
$(document).ready ->
  Boardwalk.init()