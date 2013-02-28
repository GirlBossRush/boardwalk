class Boardwalk.Models.Widget extends Backbone.Model
  idAttribute: '_id'
  urlRoot: =>
    "/api/users/#{@get('user_id')}/widgets/"

