class Boardwalk.Models.Widget extends Backbone.Model
  idAttribute: '_id'
  url: ->
      url = "/api/users/#{@get('user_id')}/widgets"
      url += "/#{@id}" if @id != undefined
      url
