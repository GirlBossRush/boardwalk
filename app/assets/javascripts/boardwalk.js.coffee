window.Boardwalk =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Boardwalk.Routers.Application
    new Boardwalk.Routers.Boards
    new Boardwalk.Routers.Users
    Backbone.history.start(pushState: true)

Boardwalk.content = (data) ->
  $('#content').html(data)

$(document).ready ->
  Boardwalk.init()
