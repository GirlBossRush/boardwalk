class Boardwalk.Models.Widget extends Backbone.Model
  # Rails expects the parameters in a nested format.
  toJSON: ->
    {widget: _.clone( @attributes )}

  idAttribute: '_id'

  url: ->
      url = "/api/users/#{@get('user_id')}/widgets"
      url += "/#{@id}" if @id != undefined
      url
