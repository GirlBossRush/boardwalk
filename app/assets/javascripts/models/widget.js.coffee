class Boardwalk.Models.Widget extends Backbone.Model
  # REFACTOR: Rails seems to receive the entire object hash, even on UPDATE.
  # PATCH would fix this issue but that's not out until Rails 4.

  # Rails expects the parameters in a nested format.
  toJSON: ->
    {widget: _.clone( @attributes )}

  idAttribute: '_id'

  url: ->
      url = "/api/users/#{@get('user_id')}/widgets"
      url += "/#{@id}" if @id != undefined
      url
