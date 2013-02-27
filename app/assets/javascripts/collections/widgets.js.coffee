class Boardwalk.Collections.Widgets extends Backbone.Collection
  url: ->
    "/api/users/#{@userID}/widgets"
  model: Boardwalk.Models.Widget
