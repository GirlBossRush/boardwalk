window.Boardwalk =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Boardwalk.Routers.Boards
    Backbone.history.start()
$(document).ready ->
  Boardwalk.init()