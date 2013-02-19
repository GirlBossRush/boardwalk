class Boardwalk.Models.User extends Backbone.Model
  urlRoot: "/api/users"

  show: ->
    Backbone.history.navigate("users/#{@id}", true)

