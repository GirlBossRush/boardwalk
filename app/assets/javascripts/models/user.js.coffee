class Boardwalk.Models.User extends Backbone.Model
  # Rails expects the parameters in a nested format.
  toJSON: ->
    {widget: _.clone( @attributes )}

  urlRoot: "/api/users"

  idAttribute: '_id'

  initWidgets: ->
    # REFACTOR: Nested models in Backbone seem to be a pain.
    # This will suffice for now.
    @widgets = new Boardwalk.Collections.Widgets(null, {userID: @id})
