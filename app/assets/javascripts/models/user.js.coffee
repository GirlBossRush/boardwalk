class Boardwalk.Models.User extends Backbone.Model
  urlRoot: "/api/users"
  idAttribute: '_id'

  widgets: ->
    # REFACTOR: Nested models in Backbone seem to be a pain.
    # This will suffice for now.
    @widgets = new Boardwalk.Collections.Widgets()
    @widgets.userID = @id