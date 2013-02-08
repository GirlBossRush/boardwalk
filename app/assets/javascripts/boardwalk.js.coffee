window.Boardwalk =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Boardwalk.Routers.Boards
    Backbone.history.start(pushState: true)
$(document).ready ->
  Boardwalk.init()