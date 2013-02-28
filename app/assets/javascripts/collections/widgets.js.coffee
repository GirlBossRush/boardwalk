class Boardwalk.Collections.Widgets extends Backbone.Collection
  url: ->
    "/api/users/#{@userID}/widgets"

  initialize: (models, params) =>
    @userID = params.userID

  model: Boardwalk.Models.Widget

