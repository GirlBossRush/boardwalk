window.Boardwalk =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    $.cookie.json = true
    new Boardwalk.Routers.Application
    new Boardwalk.Routers.Users
    new Boardwalk.Routers.Sessions
    Backbone.history.start(pushState: true)

  content: (data) ->
    $('#content').html(data)

  markdownConverter: new Markdown.getSanitizingConverter()

$(document).ready ->
  Boardwalk.init()
